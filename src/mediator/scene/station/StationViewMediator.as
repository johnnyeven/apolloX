package mediator.scene.station
{
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	
	import view.scene.station.StationViewComponent;
	
	public class StationViewMediator extends BaseMediator
	{
		public static const NAME: String = "StationViewMediator";
		public static const STATION_SHOW_NOTE: String = "StationViewMediator.StationShowNote";
		public static const STATION_DISPOSE_NOTE: String = "StationViewMediator.StationDisposeNote";
		
		public function StationViewMediator()
		{
			super(NAME, new StationViewComponent());
		}
		
		override public function listNotificationInterests():Array
		{
			return [STATION_SHOW_NOTE, STATION_DISPOSE_NOTE];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case STATION_SHOW_NOTE:
					show();
					break;
				case STATION_DISPOSE_NOTE:
					dispose();
					break;
			}
		}
		
		public function get component(): StationViewComponent
		{
			return viewComponent as StationViewComponent;
		}
	}
}