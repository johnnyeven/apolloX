package view.ship
{
	import enum.EnumShipDirection;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	
	import parameters.ship.ShipParameter;
	
	import utils.liteui.core.Component;
	
	public class ShipComponent extends Component
	{
		private var _graphic: MovieClip;
		private var _info: ShipParameter;
		private var _direction: int;
		private var _posX: Number;
		private var _posY: Number;
		
		public function ShipComponent(parameter: ShipParameter = null)
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
			
		}
		
		protected function changeDirectionByAngle(_angle:int): void
		{
			var dir: uint;
			if (_angle < 0)
			{
				_angle += 360;
			}
			dir = Math.floor(_angle / 20) + 1;
			if (dir != _direction)
			{
				_direction = dir;
			}
		}
		
		public function changeDirectionByPoint(_x: Number, _y: Number): void
		{
			changeDirectionByAngle(EnumShipDirection.radiansToDegress(EnumShipDirection.getRadians(_x - _posX, _y - _posY)) + 90);
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

		public function set posX(value:Number):void
		{
			_posX = value;
		}

		public function get posY():Number
		{
			return _posY;
		}

		public function set posY(value:Number):void
		{
			_posY = value;
		}
	}
}