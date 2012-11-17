package proxy
{
	import configuration.ConnectorContextConfig;
	
	import mediator.PromptMediator;
	import controller.scene.LoadSceneResourcesCommand;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import utils.network.CCommandCenter;
	import utils.network.command.CCommandList;
	import utils.network.command.receiving.Receive_Info_QuickStart;
	import utils.network.command.sending.Send_Info_QuickStart;
	
	public class LoginProxy extends Proxy implements IProxy
	{
		public static const NAME: String = "LoginProxy";
		
		public static const QUICK_START: uint = 0x0002;
		
		public function LoginProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		public function quickStart(): void
		{
			sendNotification(PromptMediator.LOADING_SHOW_NOTE);
			
			CCommandList.getInstance().bind(QUICK_START, Receive_Info_QuickStart);
			CCommandCenter.getInstance().add(QUICK_START, onQuickStart);
			
			var _protocol: Send_Info_QuickStart = new Send_Info_QuickStart();
			_protocol.GameId = ConnectorContextConfig.GAME_ID;
			CCommandCenter.getInstance().send(_protocol);
		}
		
		private function onQuickStart(protocol: Receive_Info_QuickStart): void
		{
			setData(protocol);
			sendNotification(PromptMediator.LOADING_HIDE_NOTE);
			sendNotification(LoadSceneResourcesCommand.LOAD_RESOURCES_NOTE);
		}
	}
}