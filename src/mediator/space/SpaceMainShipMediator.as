package mediator.space
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	
	import parameters.ship.ShipParameter;
	
	import utils.GameManager;
	
	import view.control.MainController;
	import view.render.MainRender;
	import view.space.ship.ShipComponent;
	
	public class SpaceMainShipMediator extends BaseMediator
	{
		public static const NAME: String = "SpaceMainShipMediator";
		
		public static const SHOW_NOTE: String = "SpaceMainShipMediator.ShowNote";
		
		public function SpaceMainShipMediator()
		{
			super(NAME, null);
		}
		
		public function get component(): ShipComponent
		{
			return viewComponent as ShipComponent;
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
					viewComponent = new ShipComponent(parameter);
					component.controller = new MainController();
					component.render = new MainRender();
					component.mediator = this;
					show();
					facade.sendNotification(SpaceBackgroundMediator.FOCUS_NOTE, component);
					break;
			}
		}
		
		override public function show():void
		{
			var _mediator: SpaceSceneMediator = facade.retrieveMediator(SpaceSceneMediator.NAME) as SpaceSceneMediator;
			_mediator.addMainObject(component);
			onShowComplete();
		}
	}
}