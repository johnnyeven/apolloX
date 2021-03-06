package view.space
{
	import com.greensock.TweenLite;
	
	import enum.EnumAction;
	import enum.EnumShipDirection;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import parameters.ship.ShipParameter;
	
	import view.control.BaseController;
	import view.render.Render;
	
	public class MovableComponent extends StaticComponent
	{
		protected var _direction: int;
		protected var _action: int;
		protected var _lastPosX: Number;
		protected var _lastPosY: Number;
		protected var _targetX: Number;
		protected var _targetY: Number;
		protected var _controller: BaseController;
		
		public function MovableComponent(_skin:DisplayObjectContainer=null)
		{
			super(_skin);
			_direction = EnumShipDirection.RADIANS_20;
			_action = EnumAction.STOP;
		}
		
		override protected function loadResource(): void
		{
			//Interface: Load graphic
		}
		
		override public function update(): void
		{
			if(_controller != null)
			{
				_controller.calculateAction();
			}
			super.update();
		}

		public function get direction():int
		{
			return _direction;
		}

		public function set direction(value:int):void
		{
			value %= 32;
			if(value < 1)
			{
				_direction = value + 32;
			}
			else
			{
				_direction = value;
			}
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