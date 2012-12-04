package parameters.station
{
	import utils.network.data.interfaces.IParameterFill;
	
	public class EnsureSelectItemListParameter implements IParameterFill
	{
		public var ensureName: String = "";
		public var money: Number = 0;
		public var cost: Number = 0;
		public var isCurrent: Boolean = false;
		
		public function EnsureSelectItemListParameter()
		{
		}
		
		public function fill(data:Object):void
		{
			ensureName = data.ensureName;
			money = data.money;
			cost = data.cost;
			isCurrent = data.isCurrent;
		}
	}
}