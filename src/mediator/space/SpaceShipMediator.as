package mediator.space
{
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	
	import parameters.ship.ShipParameter;
	
	import view.space.ship.ShipComponent;
	
	public class SpaceShipMediator extends BaseMediator
	{
		public static const NAME: String = "SpaceShipMediator";
		
		public static const SHOW_NOTE: String = "SpaceShipMediator.ShowNote";
		
		private var _componentContainer: Vector.<ShipComponent>;
		
		public function SpaceShipMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, null);
			
			_componentContainer = new Vector.<ShipComponent>();
			viewComponent = _componentContainer;
		}
		
		public function get component(): Vector.<ShipComponent>
		{
			return viewComponent as Vector.<ShipComponent>;
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
					var _ship: ShipComponent = new ShipComponent(parameter);
					_ship.mediator = this;
					_componentContainer.push(_ship);
//					component.controller = new MainController();
//					component.render = new MainRender();
//					component.mediator = this;
					showComponent(_ship);
					break;
			}
		}
		
		override public function show():void
		{
			return;
		}
		
		private function showComponent(_ship: ShipComponent): void
		{
			var _mediator: SpaceSceneMediator = facade.retrieveMediator(SpaceSceneMediator.NAME) as SpaceSceneMediator;
			_mediator.addObject(_ship);
			onShowComplete();
		}
	}
}