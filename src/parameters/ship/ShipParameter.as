package parameters.ship
{
	import utils.network.data.interfaces.IParameterFill;
	
	public class ShipParameter implements IParameterFill
	{
		public var id: Number;
		public var shipName: String;
		public var direction: int;
		public var currentSheild: Number;
		public var maxSheild: Number;
		public var currentArmor: Number;
		public var maxArmor: Number;
		public var currentConstruct: Number;
		public var maxConstruct: Number;
		public var x: Number;
		public var y: Number;
		
		public function ShipParameter()
		{
		}
		
		public function fill(data:Object):void
		{
			if(data != null)
			{
				id = data.id;
				shipName = data.shipName;
				direction = data.direction;
				currentSheild = data.currentSheild;
				maxSheild = data.maxSheild;
				currentArmor = data.currentArmor;
				maxArmor = data.maxArmor;
				currentConstruct = data.currentConstruct;
				maxConstruct = data.maxConstruct;
				x = data.x;
				y = data.y;
			}
		}
	}
}