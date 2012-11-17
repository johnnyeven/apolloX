package mediator.scene.station
{
	import mediator.BaseMediator;
	
	import view.scene.station.StationViewComponent;
	
	public class StationViewMediator extends BaseMediator
	{
		public static const NAME: String = "StationViewMediator";
		
		public function StationViewMediator()
		{
			super(NAME, new StationViewComponent());
		}
		
		public function get component(): StationViewComponent
		{
			return viewComponent as StationViewComponent;
		}
	}
}