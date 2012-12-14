package view.control
{
	import enum.EnumShipDirection;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	
	import view.space.MovableComponent;
	
	public class BaseController extends EventDispatcher
	{
		protected var _target: MovableComponent;
		protected var _endPoint: Point;
		protected var _nextPoint: Point;
		protected var _perception: Perception;
		
		public function BaseController()
		{
			super(this);
			_perception = new Perception(this);
		}
		
		public function clear(): void
		{
		}
		
		public function setupListener(): void
		{
		}
		
		public function removeListener(): void
		{
		}
		
		public function calculateAction(): void
		{
		}
		
		protected function changeDirectionByAngle(_angle:int): void
		{
			var dir: uint;
			if (_angle < 0)
			{
				_angle += 360;
			}
			dir = Math.floor(_angle / 11.25) + 1;
			if (dir != _target.direction)
			{
				_target.direction = dir;
			}
		}
		
		public function changeDirectionByPoint(_x: Number, _y: Number): void
		{
			changeDirectionByAngle(EnumShipDirection.degressToRadians(EnumShipDirection.getDegress(_x - _target.posX, _y - _target.posY)) + 90);
		}

		public function get target():MovableComponent
		{
			return _target;
		}

		public function set target(value:MovableComponent):void
		{
			_target = value;
		}

		public function get endPoint():Point
		{
			return _endPoint;
		}

		public function set endPoint(value:Point):void
		{
			_endPoint = value;
		}

		public function get nextPoint():Point
		{
			return _nextPoint;
		}


	}
}