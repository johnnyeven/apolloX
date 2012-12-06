package controller.scene
{
	import flash.display.DisplayObject;
	
	import mediator.scene.station.MarketViewMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import utils.resource.ResourcePool;
	
	public class CreateMarketViewCommand extends SimpleCommand
	{
		public static const LOAD_MARKET_VIEW_NOTE: String = "LoadMarketViewNote";
		
		public function CreateMarketViewCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var _mediator: MarketViewMediator = facade.retrieveMediator(MarketViewMediator.NAME) as MarketViewMediator;
			if (_mediator != null)
			{
				facade.sendNotification(MarketViewMediator.MARKET_SHOW_NOTE);
			}
			else
			{
				ResourcePool.getResourceByLoader("station_market_ui", "assets.scene1Station.market.view", onLoadComplete);
			}
		}
		
		private function onLoadComplete(target: DisplayObject): void
		{
			var _mediator: MarketViewMediator = new MarketViewMediator();
			facade.registerMediator(_mediator);
			
			facade.sendNotification(MarketViewMediator.MARKET_SHOW_NOTE);
		}
	}
}