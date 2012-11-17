package proxy
{
	import mediator.PromptMediator;
	import mediator.loader.ProgressBarMediator;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import controller.login.CreateStartMediatorCommand;
	import utils.network.CCommandCenter;
	import utils.network.command.CCommandList;
	import utils.network.command.receiving.Receive_Server_ServerList;
	import utils.network.command.sending.Send_Server_ServerList;
	import configuration.ConnectorContextConfig;
	
	public class ServerListProxy extends Proxy implements IProxy
	{
		public static const NAME: String = "ServerListProxy";
		
		public static const SERVER_LIST: uint = 0x0001;
		
		public function ServerListProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		public function getServerList(): void
		{
			sendNotification(PromptMediator.LOADING_SHOW_NOTE);
			
			CCommandList.getInstance().bind(SERVER_LIST, Receive_Server_ServerList);
			CCommandCenter.getInstance().add(SERVER_LIST, onGetServerList);
			
			var protocol: Send_Server_ServerList = new Send_Server_ServerList();
			protocol.GameId = ConnectorContextConfig.GAME_ID;
			
			CCommandCenter.getInstance().send(protocol);
		}
		
		private function onGetServerList(protocol: Receive_Server_ServerList): void
		{
			sendNotification(PromptMediator.LOADING_HIDE_NOTE);
			sendNotification(ProgressBarMediator.HIDE_RANDOM_BG);
			sendNotification(CreateStartMediatorCommand.CREATE_LOGIN_VIEW_NOTE);
			
			setData(protocol.ServerList);
		}
	}
}