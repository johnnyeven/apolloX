package parameters.space
{
	import flash.geom.Point;
	
	import utils.network.data.interfaces.IParameterFill;
	
	import view.space.StaticComponent;
	
	public class RocketRegisterParameter implements IParameterFill
	{
		public var target: StaticComponent;
		public var resourceId: int;
		public var speed: Number;
		public var acceleration: Number;
		public var targetPos: Object = new Point(1600, 2000);
		
		public function RocketRegisterParameter()
		{
		}
		
		public function fill(data:Object):void
		{
			if(data != null)
			{
				target = data.target;
				resourceId = data.resourceId;
				speed = data.speed;
				acceleration = data.acceleration;
			}
		}
	}
}