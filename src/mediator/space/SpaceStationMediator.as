package mediator.space
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	
	import parameters.ship.ShipParameter;
	import parameters.space.SpaceStationParameter;
	
	import utils.GameManager;
	
	import view.control.MainController;
	import view.render.MainRender;
	import view.render.StaticRender;
	import view.space.ship.ShipComponent;
	import view.space.station.StationComponent;
	
	public class SpaceStationMediator extends BaseMediator
	{
		public static const NAME: String = "SpaceStationMediator";
		
		public static const SHOW_NOTE: String = "SpaceStationMediator.ShowNote";
		
		public function SpaceStationMediator()
		{
			super(NAME, null);
		}
		
		public function get component(): StationComponent
		{
			return viewComponent as StationComponent;
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
					var parameter: SpaceStationParameter = notification.getBody() as SpaceStationParameter;
					viewComponent = new StationComponent(parameter);
					component.render = new StaticRender();
					component.mediator = this;
					show();
					component.addEventListener(MouseEvent.CLICK, onComponentClick);
					break;
			}
		}
		
		override public function show():void
		{
			var _mediator: SpaceSceneMediator = facade.retrieveMediator(SpaceSceneMediator.NAME) as SpaceSceneMediator;
			_mediator.addObject(component);
			onShowComplete();
		}
		
		private function onComponentClick(evt: Event): void
		{
			var _ship: ShipComponent = (ApplicationFacade.getInstance().retrieveMediator(SpaceMainShipMediator.NAME) as SpaceMainShipMediator).component;
			_ship.controller.moveTo(component.posX, component.posY);
			component.selected = true;
			evt.stopImmediatePropagation();
		}
	}
}