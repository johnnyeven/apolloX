package proxy
{
	import controller.init.LoadServerListCommand;
	import controller.login.CreateServerMediatorCommand;
	import controller.scene.LoadSceneResourcesCommand;
	
	import mediator.PromptMediator;
	
	import network.command.receiving.Receive_Info_QuickStart;
	import network.command.sending.Send_Info_QuickStart;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import utils.configuration.GlobalContextConfig;
	import utils.network.CCommandCenter;
	import utils.network.command.CCommandList;
	
	public class LoginProxy extends Proxy implements IProxy
	{
		public static const NAME: String = "LoginProxy";
		
		public static const QUICK_START: uint = 0x0008;
		
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
			_protocol.GameId = GlobalContextConfig.GameId;
			CCommandCenter.getInstance().send(_protocol);
		}
		
		private function onQuickStart(protocol: Receive_Info_QuickStart): void
		{
			facade.registerCommand(CreateServerMediatorCommand.CREATE_NOTE, CreateServerMediatorCommand);
			
			setData(protocol);
			sendNotification(PromptMediator.LOADING_HIDE_NOTE);
			sendNotification(CreateServerMediatorCommand.CREATE_NOTE);
		}
	}
}