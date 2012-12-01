package parameters.station
{
	import utils.network.data.interfaces.IParameterFill;
	
	public class MedicalItemListParameter implements IParameterFill
	{
		public var avatar: String = "";
		public var cloneName: String = "克隆体";
		public var skillPoint: Number = 0;
		public var cost: Number = 0;
		public var isCurrent: Boolean = false;
		
		public function MedicalItemListParameter()
		{
		}
		
		public function fill(data:Object):void
		{
			avatar = data.avatar;
			cloneName = data.cloneName;
			skillPoint = data.skillPoint;
			cost = data.cost;
			isCurrent = data.isCurrent;
		}
	}
}