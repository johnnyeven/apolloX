package mediator.space
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	
	import parameters.space.LeaveIntoSpaceParameter;
	
	import utils.GameManager;
	import utils.StringUtils;
	import utils.events.MapEvent;
	
	import view.space.background.SpaceBackgroundComponent;
	
	public class SpaceBackgroundMediator extends BaseMediator
	{
		public static const NAME: String = "SpaceBackgroundMediator";
		public static const SHOW_MAP_NOTE: String = "SpaceBackgroundMediator.ShowMapNote";
		public static const DISPOSE_MAP_NOTE: String = "SpaceBackgroundMediator.DisposeMapNote";
		private var _mouseStatus: Boolean = false;
		private var _preMouseX: Number;
		private var _preMouseY: Number;
		
		public function SpaceBackgroundMediator()
		{
			super(NAME, new SpaceBackgroundComponent());
			
			component.mediator = this;
			component.addEventListener(MapEvent.MAP_READY, onBackgroundReady);
		}
		
		public function get component(): SpaceBackgroundComponent
		{
			return viewComponent as SpaceBackgroundComponent;
		}
		
		override public function listNotificationInterests():Array
		{
			return [SHOW_MAP_NOTE, DISPOSE_MAP_NOTE];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case SHOW_MAP_NOTE:
					var parameter: LeaveIntoSpaceParameter = notification.getBody() as LeaveIntoSpaceParameter;
					if(parameter != null)
					{
						component.startX = parameter.startX;
						component.startY = parameter.startY;
						component.id = parameter.id;
						
						show();
					}
					break;
				case DISPOSE_MAP_NOTE:
					dispose();
					break;
			}
		}
		
		override public function dispose():void
		{
			super.dispose();
			
			GameManager.container.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			GameManager.container.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			GameManager.container.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			GameManager.container.removeEventListener(Event.ENTER_FRAME, onRender);
		}
		
		private function onBackgroundReady(evt: MapEvent): void
		{
			GameManager.container.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			GameManager.container.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			GameManager.container.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			GameManager.container.addEventListener(Event.ENTER_FRAME, onRender);
		}
		
		private function onRender(evt: Event): void
		{
			component.render();
		}
		
		private function onMouseDown(evt: MouseEvent): void
		{
			_mouseStatus = true;
			_preMouseX = evt.stageX;
			_preMouseY = evt.stageY;
		}
		
		private function onMouseUp(evt: MouseEvent): void
		{
			_mouseStatus = false;
			_preMouseX = evt.stageX;
			_preMouseY = evt.stageY;
		}
		
		private function onMouseMove(evt: MouseEvent): void
		{
			if(_mouseStatus)
			{
				var offsetX: Number = _preMouseX - evt.stageX;
				var offsetY: Number = _preMouseY - evt.stageY;
				component.centerX += offsetX * .1;
				component.centerY += offsetY * .1;
				
				_preMouseX = evt.stageX;
				_preMouseY = evt.stageY;
			}
		}
	}
}