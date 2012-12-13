package view.control
{
	import flash.geom.Point;
	
	import view.space.SpaceComponent;

	public class Perception
	{
		private var _control: BaseController;
		
		public function Perception(ctrl: BaseController)
		{
			_control = ctrl;
		}
		
		public function calcDistanceToTarget(target: SpaceComponent): Number
		{
			return Point.distance(new Point(_control.target.posX, _control.target.posY), new Point(target.posX, target.posY));
		}
	}
}