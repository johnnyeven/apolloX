package parameters.space
{
	import utils.network.data.interfaces.IParameterFill;
	
	public class SpaceStationParameter implements IParameterFill
	{
		public var id: Number;
		public var stationName: String;
		public var stationResource: int;
		public var x: Number;
		public var y: Number;
		
		public function SpaceStationParameter()
		{
		}
		
		public function fill(data:Object):void
		{
			if(data != null)
			{
				id = data.id;
				stationName = data.stationName;
				stationResource = data.stationResource;
				x = data.x;
				y = data.y;
			}
		}
	}
}