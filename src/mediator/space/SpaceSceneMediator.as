package mediator.space
{
	import controller.space.CreateMainShipCommand;
	import controller.space.CreateSpaceBackgroundCommand;
	import controller.space.CreateStationCommand;
	
	import flash.events.Event;
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
		public static const CREATE_BACKGROUND_NOTE: String = "SpaceSceneMediator.CreateBackgroundNote";
		public static const CREATE_COMPONENT_NOTE: String = "SpaceSceneMediator.CreateComponentNote";
		
		protected var _backgroundComponent: SpaceBackgroundComponent;
		protected var _objectList: Array;
		protected var _renderList: Array;
		protected var _mainShip: ShipComponent;
		
		public function SpaceSceneMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			
			_objectList = new Array();
			_renderList = new Array();
		}
		
		private function createBackground(): void
		{
			sendNotification(CreateSpaceBackgroundCommand.CREATE_SPACE_BACKGROUND_NOTE);
			_backgroundComponent = (ApplicationFacade.getInstance().retrieveMediator(SpaceBackgroundMediator.NAME) as SpaceBackgroundMediator).component;
		}
		
		private function createComponents(): void
		{
			sendNotification(CreateStationCommand.CREATE_STATION_NOTE);
			sendNotification(CreateMainShipCommand.CREATE_MAIN_SHIP_NOTE);
			_mainShip = (ApplicationFacade.getInstance().retrieveMediator(SpaceMainShipMediator.NAME) as SpaceMainShipMediator).component;
			
			GameManager.instance.addEventListener(Event.ENTER_FRAME, render);
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
		
		private function render(evt: Event = null): void
		{
			updateTimer();
			_backgroundComponent.render();
			_mainShip.update();
			
//			if(_renderList.length == 0)
//			{
//				return;
//			}
			
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
			for each(var _child: StaticComponent in _objectList)
			{
				if(_child == _mainShip)
				{
					continue;
				}
				if(_backgroundComponent.cameraCutView.contains(_child.posX, _child.posY))
				{
					pushRenderList(_child);
				}
				else
				{
					pullRenderList(_child);
				}
			}
		}
		
		public function addObject(child: StaticComponent): void
		{
			if(_objectList.indexOf(child) != -1)
			{
				return;
			}
			_objectList.push(child);
			pushRenderList(child);
			if(_backgroundComponent.cameraView.contains(child.posX, child.posY))
			{
				pushRenderList(child);
			}
		}
		
		public function addMainObject(child: StaticComponent): void
		{
			GameManager.instance.addView(child);
		}
		
		public function removeObject(child: StaticComponent): void
		{
			var i: int = _objectList.indexOf(child);
			if (i != -1)
			{
				_objectList.splice(i, 1);
			}
			pullRenderList(child);
		}
		
		public function removeMainObject(child: StaticComponent): void
		{
			GameManager.instance.removeView(child);
		}
		
		private function pushRenderList(child: StaticComponent): void
		{
			if(_renderList.indexOf(child) != -1)
			{
				return;
			}
			_renderList.push(child);
			GameManager.instance.addBase(child);
			child.inUse = true;
			child.isMovingIn();
		}
		
		private function pullRenderList(child: StaticComponent, dispose: Boolean = false): void
		{
			var i: int = _renderList.indexOf(child);
			if(i != -1)
			{
				_renderList.splice(i, 1);
				child.inUse = false;
				child.isMovingOut(function(): void
				{
					GameManager.instance.removeBase(child);
					if(dispose)
					{
						child.dispose();
					}
				});
			}
			else if(dispose)
			{
				child.dispose();
			}
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
			return [CREATE_BACKGROUND_NOTE, CREATE_COMPONENT_NOTE];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case CREATE_BACKGROUND_NOTE:
					createBackground();
					break;
				case CREATE_COMPONENT_NOTE:
					createComponents();
					break;
			}
		}
	}
}