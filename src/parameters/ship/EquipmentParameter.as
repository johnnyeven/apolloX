package parameters.ship
{
	import flash.errors.IllegalOperationError;
	
	import utils.network.data.interfaces.IParameterFill;
	
	public class EquipmentParameter implements IParameterFill
	{
		public var resourceId: int;
		public var equipmentType: int;
		
		public function EquipmentParameter()
		{
		}
		
		public function fill(data:Object):void
		{
			if(data != null)
			{
				if(data.resourceId != null && data.equipmentType != null)
				{
					resourceId = data.resourceId;
					equipmentType = data.equipmentType;
				}
				else
				{
					throw new IllegalOperationError("EquipmentParameter Error: resourceId or equipmentType empty.");
				}
			}
		}
	}
}