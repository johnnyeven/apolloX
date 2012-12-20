package view.scene.station
{
	import controller.space.CreateSpaceBackgroundCommand;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	import mediator.scene.station.StationViewMediator;
	
	import utils.liteui.component.Button;
	import utils.liteui.core.Component;
	
	public class StationLeftMenuComponent extends Component
	{
		private var _btnLeft: Button;
		
		public function StationLeftMenuComponent(_skin:DisplayObjectContainer=null)
		{
			super(_skin);
			
			_btnLeft = getUI(Button, "btnLeft") as Button;
			
			sortChildIndex();

			_btnLeft.addEventListener(MouseEvent.CLICK, onBtnLeftClick);
		}
		
		private function onBtnLeftClick(evt: MouseEvent): void
		{
			ApplicationFacade.getInstance().sendNotification(CreateSpaceBackgroundCommand.CREATE_SPACE_BACKGROUND_NOTE);
			ApplicationFacade.getInstance().sendNotification(StationViewMediator.STATION_DISPOSE_NOTE);
		}
	}
}