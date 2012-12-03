package parameters.station
{
	import utils.network.data.interfaces.IParameterFill;
	
	public class EnsureItemListParameter implements IParameterFill
	{
		public var avatar: String = "";
		public var shipName: String = "";
		public var level: int = 0;
		public var endTime: int = 0;
		
		public function EnsureItemListParameter()
		{
		}
		
		public function fill(data:Object):void
		{
			avatar = data.avatar;
			shipName = data.shipName;
			level = data.level;
			endTime = data.endTime;
		}
	}
}