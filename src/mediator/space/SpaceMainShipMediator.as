package mediator.space
{
	import flash.events.Event;
	
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	
	import parameters.ship.ShipParameter;
	
	import utils.GameManager;
	
	import view.control.MainController;
	import view.render.MainRender;
	import view.space.SpaceComponent;
	
	public class SpaceMainShipMediator extends BaseMediator
	{
		public static const NAME: String = "SpaceMainShipMediator";
		
		public static const SHOW_NOTE: String = "SpaceMainShipMediator.ShowNote";
		
		public function SpaceMainShipMediator()
		{
			super(NAME, null);
		}
		
		public function get component(): SpaceComponent
		{
			return viewComponent as SpaceComponent;
		}
		
		override public function listNotificationInterests():Array
		{
			return [SHOW_NOTE];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case SHOW_NOTE:
					var parameter: ShipParameter = notification.getBody() as ShipParameter;
					viewComponent = new SpaceComponent(parameter);
					component.controller = new MainController();
					component.render = new MainRender();
					component.mediator = this;
					show();
					facade.sendNotification(SpaceBackgroundMediator.FOCUS_NOTE, component);
					GameManager.container.addEventListener(Event.ENTER_FRAME, onRender);
					break;
			}
		}
		
		private function onRender(evt: Event): void
		{
			component.update();
		}
	}
}