package utils.network.data 
{
	/**
	 * ...
	 * @author Johnny.EVE
	 */
	public class CRoleParameter 
	{
		private var _objectId: String;
		private var _playerName: String;
		private var _speed: int;
		private var _startX: int;
		private var _startY: int;
		
		public function CRoleParameter(objectId: String = null, playerName: String = null, speed: int = int.MIN_VALUE, startX: int = int.MIN_VALUE, startY: int = int.MIN_VALUE) 
		{
			_objectId = objectId;
			_playerName = playerName;
			_speed = speed;
			_startX = startX;
			_startY = startY;
		}
		
		public function get objectId():String 
		{
			return _objectId;
		}
		
		public function set objectId(value:String):void 
		{
			_objectId = value;
		}
		
		public function get playerName():String 
		{
			return _playerName;
		}
		
		public function set playerName(value:String):void 
		{
			_playerName = value;
		}
		
		public function get speed():int 
		{
			return _speed;
		}
		
		public function set speed(value:int):void 
		{
			_speed = value;
		}
		
		public function get startX():int 
		{
			return _startX;
		}
		
		public function set startX(value:int):void 
		{
			_startX = value;
		}
		
		public function get startY():int 
		{
			return _startY;
		}
		
		public function set startY(value:int):void 
		{
			_startY = value;
		}
	}

}