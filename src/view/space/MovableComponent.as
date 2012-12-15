package view.space
{
	import com.greensock.TweenLite;
	
	import enum.EnumShipDirection;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import parameters.ship.ShipParameter;
	
	import utils.resource.ResourcePool;
	
	import view.control.BaseController;
	import view.render.Render;
	
	public class MovableComponent extends StaticComponent
	{
		protected var _info: ShipParameter;
		protected var _direction: int;
		protected var _action: int;
		protected var _lastPosX: Number;
		protected var _lastPosY: Number;
		protected var _targetX: Number;
		protected var _targetY: Number;
		protected var _controller: BaseController;
		
		public function MovableComponent(parameter: ShipParameter = null)
		{
			super();
			_direction = EnumShipDirection.RADIANS_20;
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
		
		protected function loadResource(): void
		{
			ResourcePool.getResourceByLoader("resources/ship/ship" + _info.shipResource + ".swf", "space.ship.Ship" + _info.shipResource, onResourceLoaded);
		}
		
		protected function onResourceLoaded(target: DisplayObject): void
		{
			_graphic = target as MovieClip;
			_graphic.gotoAndStop(_direction);
			addChild(_graphic);
		}
		
		override public function update(): void
		{
			_controller.calculateAction();
			super.update();
		}

		public function get info():ShipParameter
		{
			return _info;
		}

		public function set info(value:ShipParameter):void
		{
			_info = value;
		}

		public function get direction():int
		{
			return _direction;
		}

		public function set direction(value:int):void
		{
			_direction = value;
		}
		
		public function isMovingOut(callback: Function = null): void
		{
			TweenLite.to(this, 1, {alpha: 0, onComplete: callback});
		}
		
		public function isMovingIn(callback: Function = null): void
		{
			TweenLite.to(this, 1, {alpha: 1, onComplete: callback});
		}
		
		override public function dispose():void
		{
			super.dispose();
			if(_graphic != null)
			{
				_graphic = null;
			}
			
			if(!inUse)
			{
				if(_controller != null)
				{
					_controller = null;
				}
				_render = null;
				canBeAttack = false;
			}
			else
			{
				inUse = false;
				isMovingOut(dispose);
			}
		}

		public function get controller():BaseController
		{
			return _controller;
		}

		public function set controller(value:BaseController):void
		{
			if (_controller != null)
			{
				_controller.removeListener();
			}
			if (value != null)
			{
				_controller = value;
				_controller.target = this;
				_controller.setupListener();
			}
		}

		public function get action():int
		{
			return _action;
		}

		public function set action(value:int):void
		{
			_action = value;
		}

		public function get lastPosX():Number
		{
			return _lastPosX;
		}

		public function set lastPosX(value:Number):void
		{
			_lastPosX = value;
		}

		public function get lastPosY():Number
		{
			return _lastPosY;
		}

		public function set lastPosY(value:Number):void
		{
			_lastPosY = value;
		}


	}
}