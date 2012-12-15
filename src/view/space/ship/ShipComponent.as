package view.space.ship
{
	import parameters.ship.ShipParameter;
	
	import view.render.ShipStopRender;
	import view.space.MovableComponent;
	
	public class ShipComponent extends MovableComponent
	{
		public function ShipComponent(parameter:ShipParameter=null)
		{
			super(parameter);
			addRender(new ShipStopRender());
		}
	}
}