package view.space.effects.rocket
{
	import enum.EnumAction;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	import parameters.space.RocketRegisterParameter;
	
	import utils.events.LoaderEvent;
	import utils.loader.ResourceLoadManager;
	import utils.loader.XMLLoader;
	import utils.resource.ResourcePool;
	
	import view.render.RocketEngineRender;
	import view.space.MovableComponent;
	
	public class EffectRocketComponent extends MovableComponent
	{
		protected var _info: RocketRegisterParameter;
		protected var _configXML: XML;
		private var _currentSpeed: Number;
		private var _maxSpeed: Number;
		protected var _effectLayer: Sprite;
		protected var _explodeEffect: MovieClip;
		protected var _resourceReady: Boolean = false;
		
		public function EffectRocketComponent(parameter: RocketRegisterParameter=null)
		{
			super();
			if(parameter != null)
			{
				_info = parameter;
				//_direction = parameter.target;
				_posX = parameter.target.posX;
				_posY = parameter.target.posY;
				_lastPosX = parameter.target.posX;
				_lastPosY = parameter.target.posY;
				if(parameter.target is MovableComponent)
				{
					_direction = (parameter.target as MovableComponent).direction;
				}
			}
			
			loadResourceConfig();
		}
		
		protected function loadResourceConfig(): void
		{
			ResourceLoadManager.load("resources/rocket/xml/rocket" + _info.resourceId + ".xml", false, "", onConfigLoaded);
		}
		
		protected function onConfigLoaded(evt: LoaderEvent): void
		{
			var _loader: XMLLoader = evt.loader as XMLLoader;
			_configXML = _loader.configXML;
			_info.speed = parseFloat(_configXML.speed);
			_info.acceleration = parseFloat(_configXML.acceleration);
			_currentSpeed = 0;
			_maxSpeed = _info.speed;
			loadResource();
		}
		
		override protected function loadResource(): void
		{
			ResourceLoadManager.load("rocket" + _info.resourceId + "_resource", false, "", onResourceLoaded);
		}
		
		protected function onResourceLoaded(evt: LoaderEvent): void
		{
			_graphic = new MovieClip();
			
			var _matrix: Matrix;
			var _offsetX: Number;
			var _offsetY: Number;
			if(_configXML.hasOwnProperty("rockets"))
			{
				var bitmap: BitmapData;
				for(var i: int = 0; i<_configXML.rockets.texture.length(); i++)
				{
					bitmap = (ResourcePool.getResource(_configXML.rockets.texture[i]["@class"]) as Bitmap).bitmapData;
					_offsetX = parseFloat(_configXML.rockets.texture[i]["@x"]);
					_offsetY = parseFloat(_configXML.rockets.texture[i]["@y"]);
					_matrix = new Matrix();
					_matrix.translate(_offsetX, _offsetY);
					_graphic.graphics.beginBitmapFill(bitmap, _matrix, false, true);
					_graphic.graphics.drawRect(_offsetX, _offsetY, bitmap.width, bitmap.height);
					_graphic.graphics.endFill();
				}
			}
			addChild(_graphic);
			
			_effectLayer = new Sprite();
			addChild(_effectLayer);
			
			_resourceReady = true;
			if(_configXML.hasOwnProperty("smoke"))
			{
				addRender(new RocketEngineRender());
			}
		}
		
		public function explodePre(): void
		{
			_graphic.visible = false;
		}
		
		public function explode(): void
		{
			_action = EnumAction.EXPLODE;
			_explodeEffect = ResourcePool.getResource(_configXML.explode.texture[0]["@class"]) as MovieClip;
			_effectLayer.addChild(_explodeEffect);
		}

		public function get info():RocketRegisterParameter
		{
			return _info;
		}

		public function set info(value:RocketRegisterParameter):void
		{
			_info = value;
		}

		public function get currentSpeed():Number
		{
			return _currentSpeed;
		}

		public function set currentSpeed(value:Number):void
		{
			if(value > _maxSpeed)
			{
				_currentSpeed = _maxSpeed;
			}
			else if(value < 0)
			{
				_currentSpeed = 0;
			}
			else
			{
				_currentSpeed = value;
			}
		}
		
		override public function set direction(value:int):void
		{
			_direction = value;
		}
		
		public function get effectLayer():Sprite
		{
			return _effectLayer;
		}

		public function get configXML():XML
		{
			return _configXML;
		}

		public function get resourceReady():Boolean
		{
			return _resourceReady;
		}

		override public function dispose():void
		{
			_info = null;
			_configXML = null;
			_effectLayer.removeChildren();
			_effectLayer = null;
			
			super.dispose();
		}

		public function get explodeEffect():MovieClip
		{
			return _explodeEffect;
		}

	}
}