package view.space.ship
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import parameters.ship.ShipParameter;
	
	import utils.resource.ResourcePool;
	
	import view.render.ShipEngineRender;
	import view.render.ShipStopRender;
	import view.space.MovableComponent;
	
	public class ShipComponent extends MovableComponent
	{
		protected var _info: ShipParameter;
		protected var _effectLayer: Sprite;
		
		public function ShipComponent(parameter:ShipParameter=null)
		{
			super();
			if(parameter != null)
			{
				_info = parameter;
				_direction = parameter.direction;
				_posX = parameter.x;
				_posY = parameter.y;
				_lastPosX = parameter.x;
				_lastPosY = parameter.y;
			}
			
			loadResource();
		}
		
		public function get info():ShipParameter
		{
			return _info;
		}
		
		public function set info(value:ShipParameter):void
		{
			_info = value;
		}
		
		override protected function loadResource(): void
		{
			ResourcePool.getResourceByLoader("resources/ship/ship" + _info.shipResource + ".swf", "space.ship.Ship" + _info.shipResource, onResourceLoaded);
		}
		
		protected function onResourceLoaded(target: DisplayObject): void
		{
			_graphic = target as MovieClip;
			_graphic.gotoAndStop(_direction);
			addChild(_graphic);
			
			_effectLayer = new Sprite();
			addChild(_effectLayer);
			
			addRender(new ShipEngineRender());
			addRender(new ShipStopRender());
		}

		public function get effectLayer():Sprite
		{
			return _effectLayer;
		}

	}
}