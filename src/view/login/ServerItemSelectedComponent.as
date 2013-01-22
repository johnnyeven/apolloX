package view.login
{
	import controller.init.InitGameSocketCommand;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	import parameters.CServerListParameter;
	
	import utils.liteui.component.CaptionButton;
	import utils.liteui.component.Label;
	import utils.liteui.core.Component;
	import utils.resource.ResourcePool;
	
	public class ServerItemSelectedComponent extends Component
	{
		private var lblDelayTitle: Label;
		private var lblDelay: Label;
		private var btnEnter: CaptionButton;
		private var _serverListParameter: CServerListParameter;
		
		public function ServerItemSelectedComponent()
		{
			super(ResourcePool.getResource("ui.login.ServerItemSelectedSkin") as DisplayObjectContainer);
			
			lblDelayTitle = getUI(Label, "lblDelay") as Label;
			lblDelay = getUI(Label, "delay") as Label;
			btnEnter = getUI(CaptionButton, "btnEnter") as CaptionButton;
			
			btnEnter.addEventListener(MouseEvent.CLICK, onBtnEnterClick);
		}
		
		public function set serverListParameter(value: CServerListParameter): void
		{
			if(value != null && value != _serverListParameter)
			{
				_serverListParameter = value;
				updateUI();
			}
		}
		
		private function updateUI(): void
		{
			if(_serverListParameter != null)
			{
				
			}
		}
		
		private function onBtnEnterClick(evt: MouseEvent): void
		{
			ApplicationFacade.getInstance().registerCommand(InitGameSocketCommand.CONNECT_SOCKET_NOTE, InitGameSocketCommand);
			ApplicationFacade.getInstance().sendNotification(InitGameSocketCommand.CONNECT_SOCKET_NOTE, _serverListParameter);
		}
	}
}