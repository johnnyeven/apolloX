package mediator.space
{
	import controller.space.CreateSpaceBackgroundCommand;
	
	import flash.utils.getTimer;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import utils.GameManager;
	import utils.configuration.GlobalContextConfig;
	
	import view.space.StaticComponent;
	import view.space.background.SpaceBackgroundComponent;
	import view.space.ship.ShipComponent;
	
	public class SpaceSceneMediator extends Mediator implements IMediator
	{
		public static const NAME: String = "SpaceSceneMediator";
		public static const CREATE_NOTE: String = "SpaceSceneMediator.CreateNote";
		
		protected var _backgroundComponent: SpaceBackgroundComponent;
		protected var _objectList: Array;
		protected var _renderList: Array;
		protected var _mainShip: ShipComponent;
		
		public function SpaceSceneMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			
			_backgroundComponent = (ApplicationFacade.getInstance().retrieveMediator(SpaceBackgroundMediator.NAME) as SpaceBackgroundMediator).component;
			_mainShip = (ApplicationFacade.getInstance().retrieveMediator(SpaceMainShipMediator.NAME) as SpaceMainShipMediator).component;
			_objectList = new Array();
			_renderList = new Array();
		}
		
		private function createScene(): void
		{
			sendNotification(CreateSpaceBackgroundCommand.CREATE_SPACE_BACKGROUND_NOTE);
		}
		
		private function clear(): void
		{
			_objectList.splice(0, _objectList.length);
			_renderList.splice(0, _renderList.length);
			
			if(GameManager.instance.backLayer.numChildren > 0)
			{
				GameManager.instance.backLayer.removeChildren();
			}
			if(GameManager.instance.baseLayer.numChildren > 0)
			{
				GameManager.instance.baseLayer.removeChildren();
			}
		}
		
		private function render(): void
		{
			updateTimer();
			_backgroundComponent.render();
			
			if(_renderList.length == 0)
			{
				return;
			}
			
			var _length: int = _renderList.length;
			_renderList.sortOn("zIndex", Array.NUMERIC);
			
			var _renderItem: StaticComponent;
			var _children: StaticComponent;
			while(_length--)
			{
				_renderItem = _renderList[_length];
				try
				{
					_children = GameManager.instance.baseLayer.getChildAt(_length) as StaticComponent;
					if(_children != _renderItem)
					{
						GameManager.instance.baseLayer.setChildIndex(_renderItem, _length);
					}
				}
				catch(err: Error)
				{
				}
				_renderItem.update();
			}
			refreshScene();
		}
		
		private function refreshScene(): void
		{
			
		}
		
		private function updateTimer(): void
		{
			GlobalContextConfig.Timer = getTimer();
		}
		
		private function changeScene(): void
		{
			
		}
		
		override public function listNotificationInterests():Array
		{
			return [CREATE_NOTE];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case CREATE_NOTE:
					createScene():
					break;
			}
		}
	}
}