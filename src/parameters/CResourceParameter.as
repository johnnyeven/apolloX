package parameters 
{
	/**
	 * ...
	 * @author Johnny.EVE
	 */
	public class CResourceParameter 
	{
		private var _resourceId: uint;
		private var _resourceName: String;
		/**
		 * 对于CResourceCenter类来说，_resourceAmount表示剩余资源数，对于consumeList,produceList来说，没有_resourceAmount这个值，只有_resourceModified
		 */
		private var _resourceAmount: Number;
		private var _resourceModified: int;
		private var _resourceMax: Number;
		
		public function CResourceParameter(_resourceId: uint, _resourceName: String, _resourceAmount: Number, _resourceModified: int, _resourceMax: uint = 100000) 
		{
			this._resourceId = _resourceId;
			this._resourceName = _resourceName;
			this._resourceAmount = _resourceAmount;
			this._resourceModified = _resourceModified;
			this._resourceMax = _resourceMax;
		}
		
		public function get resourceId(): uint
		{
			return _resourceId;
		}
		
		public function set resourceId(value:uint): void 
		{
			_resourceId = value;
		}
		
		public function get resourceName(): String 
		{
			return _resourceName;
		}
		
		public function set resourceName(value: String): void 
		{
			_resourceName = value;
		}
		
		public function get resourceAmount(): Number 
		{
			return _resourceAmount;
		}
		
		public function set resourceAmount(value: Number): void 
		{
			_resourceAmount = value;
		}
		
		public function get resourceModified():int 
		{
			return _resourceModified;
		}
		
		public function set resourceModified(value: int):void 
		{
			_resourceModified = value;
		}
		
		public function get resourceMax():Number 
		{
			return _resourceMax;
		}
		
		public function set resourceMax(value:Number):void 
		{
			_resourceMax = value;
		}
		
	}

}