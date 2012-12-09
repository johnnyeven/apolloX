package parameters.space
{
	import utils.network.data.interfaces.IParameterFill;
	
	public class LeaveIntoSpaceParameter implements IParameterFill
	{
		public var id: String;
		public var startX: int;
		public var startY: int;
		
		public function LeaveIntoSpaceParameter()
		{
		}
		
		public function fill(data:Object):void
		{
			id = data.id;
			startX = data.startX;
			startY = data.startY;
		}
	}
}