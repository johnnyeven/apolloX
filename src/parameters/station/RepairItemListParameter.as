package parameters.station
{
	import utils.network.data.interfaces.IParameterFill;
	
	public class RepairItemListParameter implements IParameterFill
	{
		public var avatar: String = "";
		public var shipName: String = "克隆体";
		public var currentSheild: Number = 0;
		public var maxSheild: Number = 0;
		public var currentArmor: Number = 0;
		public var maxArmor: Number = 0;
		public var currentConstruct: Number = 0;
		public var maxConstruct: Number = 0;
		public var cost: Number = 0;
		
		public function RepairItemListParameter()
		{
		}
		
		public function fill(data:Object):void
		{
			avatar = data.avatar;
			shipName = data.cloneName;
			currentSheild = data.currentSheild;
			maxSheild = data.maxSheild;
			currentArmor = data.currentArmor;
			maxArmor = data.maxArmor;
			currentConstruct = data.currentConstruct;
			maxConstruct = data.maxConstruct;
			cost = data.cost;
		}
	}
}