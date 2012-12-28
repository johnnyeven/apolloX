package view.space.effects.rocket
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	
	import parameters.space.RocketRegisterParameter;
	
	import utils.events.LoaderEvent;
	import utils.loader.ResourceLoadManager;
	import utils.loader.XMLLoader;
	import utils.resource.ResourcePool;
	
	import view.space.MovableComponent;
	
	public class EffectRocketComponent extends MovableComponent
	{
		protected var _info: RocketRegisterParameter;
		protected var _configXML: XML;
		private var _currentSpeed: Number;
		private var _maxSpeed: Number;
		
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
			var bitmap: BitmapData = (ResourcePool.getResource("space.rocket.Rocket" + _info.resourceId) as Bitmap).bitmapData;
			_graphic = new MovieClip();
			_graphic.graphics.beginBitmapFill(bitmap, null, false, true);
			_graphic.graphics.drawRect(0, 0, bitmap.width, bitmap.height);
			_graphic.graphics.endFill();
			addChild(_graphic);
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
	}
}