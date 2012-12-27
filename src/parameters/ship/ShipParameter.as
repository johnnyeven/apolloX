package parameters.ship
{
	import utils.network.data.interfaces.IParameterFill;
	
	public class ShipParameter implements IParameterFill
	{
		public var id: Number;
		public var shipName: String;
		public var shipResource: int;
		public var direction: int;
		public var currentSheild: Number;
		public var maxSheild: Number;
		public var currentArmor: Number;
		public var maxArmor: Number;
		public var currentConstruct: Number;
		public var maxConstruct: Number;
		public var x: Number;
		public var y: Number;
		public var speed: Number;
		public var equipments: Vector.<EquipmentParameter>;
		
		public function ShipParameter()
		{
			equipments = new Vector.<EquipmentParameter>(24);
		}
		
		public function fill(data:Object):void
		{
			if(data != null)
			{
				id = data.id;
				shipName = data.shipName;
				shipResource = data.shipResource;
				direction = data.direction;
				currentSheild = data.currentSheild;
				maxSheild = data.maxSheild;
				currentArmor = data.currentArmor;
				maxArmor = data.maxArmor;
				currentConstruct = data.currentConstruct;
				maxConstruct = data.maxConstruct;
				x = data.x;
				y = data.y;
				speed = data.speed;
			}
		}
	}
}