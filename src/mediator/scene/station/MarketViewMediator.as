package mediator.scene.station
{
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	
	import utils.enum.PopupEffect;
	
	import view.scene.station.market.MarketViewComponent;
	
	public class MarketViewMediator extends BaseMediator
	{
		public static const NAME: String = "MarketViewMediator";
		
		public static const MARKET_SHOW_NOTE: String = "MarketViewMediator.market_show_note";
		public static const MARKET_DISPOSE_NOTE: String = "MarketViewMediator.market_dispose_note";
		
		public function MarketViewMediator()
		{
			super(NAME, new MarketViewComponent());
			component.mediator = this;
			_isPopUp = true;
			popUpEffect = PopupEffect.TOP;
			onShow = onShowCallback;
		}
		
		public function get component(): MarketViewComponent
		{
			return viewComponent as MarketViewComponent;
		}
		
		override public function listNotificationInterests():Array
		{
			return [MARKET_SHOW_NOTE, MARKET_DISPOSE_NOTE];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case MARKET_SHOW_NOTE:
					show();
					break;
				case MARKET_DISPOSE_NOTE:
					dispose();
					break;
			}
		}
		
		private function onShowCallback(_mediator: BaseMediator): void
		{
			component.showComponent();
		}
	}
}