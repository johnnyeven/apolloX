package view.space
{
	import com.greensock.TweenLite;
	
	import enum.EnumShipDirection;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import parameters.ship.ShipParameter;
	
	import utils.liteui.core.Component;
	import utils.resource.ResourcePool;
	
	import view.control.BaseController;
	import view.render.Render;
	
	public class SpaceComponent extends Component
	{
		public var focused: Boolean = false;
		public var inUse: Boolean = true;
		public var canBeAttack: Boolean = false;
		public var staticUpdate: Boolean = false;
		protected var _graphic: MovieClip;
		protected var _info: ShipParameter;
		protected var _direction: int;
		protected var _action: int;
		protected var _posX: Number;
		protected var _posY: Number;
		protected var _targetX: Number;
		protected var _targetY: Number;
		protected var _zIndex: uint = 0;
		protected var _zIndexOffset: uint = 0;
		protected var _controller: BaseController;
		protected var _render: Render;
		
		public function SpaceComponent(parameter: ShipParameter = null)
		{
			super();
			_direction = EnumShipDirection.RADIANS_20;
			if(parameter != null)
			{
				_info = parameter;
				_direction = parameter.direction;
				_posX = parameter.x;
				_posY = parameter.y;
			}
			
			loadResource();
		}
		
		protected function loadResourceConfig(): void
		{
			
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
		
		public function update(): void
		{
			_controller.calculateAction();
			if(_graphic != null && inUse)
			{
				_render.rendering();
			}
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

		public function get posX():Number
		{
			return _posX;
		}

		public function get posY():Number
		{
			return _posY;
		}
		
		public function setPos(_x: Number, _y: Number): void
		{
			_posX = _x;
			_posY = _y;
			_zIndex = y;
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

		public function get graphic():MovieClip
		{
			return _graphic;
		}

		public function set graphic(value:MovieClip):void
		{
			_graphic = value;
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

		public function get render():Render
		{
			return _render;
		}

		public function set render(value:Render):void
		{
			_render = value;
			_render.target = this;
		}

		public function get zIndex():uint
		{
			return _zIndex + _zIndexOffset;
		}

		public function get zIndexOffset():uint
		{
			return _zIndexOffset;
		}

		public function set zIndexOffset(value:uint):void
		{
			_zIndexOffset = value;
		}

		public function get action():int
		{
			return _action;
		}

		public function set action(value:int):void
		{
			_action = value;
		}

	}
}