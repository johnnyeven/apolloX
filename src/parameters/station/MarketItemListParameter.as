package parameters.station
{
	import utils.network.data.interfaces.IParameterFill;
	
	public class MarketItemListParameter implements IParameterFill
	{
		public var id: Number;
		public var stationName: String;
		public var itemCount: Number;
		public var itemCost: Number;
		public var endTime: int;
		
		public function MarketItemListParameter()
		{
		}
		
		public function fill(data:Object):void
		{
			if(data != null)
			{
				id = data.id;
				stationName = data.stationName;
				itemCount = data.itemCount;
				itemCost = data.itemCost;
				endTime = data.endTime;
			}
		}
	}
}