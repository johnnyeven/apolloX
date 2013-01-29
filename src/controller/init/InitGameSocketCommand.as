package controller.init
{
	import controller.scene.LoadSceneResourcesCommand;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	
	import mediator.login.ServerMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import parameters.CServerListParameter;
	
	import utils.configuration.SocketContextConfig;
	import utils.events.CommandEvent;
	import utils.network.CCommandCenter;
	import utils.network.tcp.CNetSocket;
	
	public class InitGameSocketCommand extends SimpleCommand
	{
		public static const CONNECT_SOCKET_NOTE: String = "InitGameSocketCommand.ConnectSocketNote";
		
		public function InitGameSocketCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var _parameter: CServerListParameter = notification.getBody() as CServerListParameter;
			
			if(_parameter != null)
			{
				SocketContextConfig.server_ip = _parameter.ip;
				SocketContextConfig.server_port = _parameter.port;
			}
			
			var _commandCenter: CCommandCenter = CCommandCenter.getInstance();
			_commandCenter.dispose();
			_commandCenter = CCommandCenter.getInstance();
			_commandCenter.addEventListener(CommandEvent.CLOSED_EVENT, onClosed);
			_commandCenter.addEventListener(CommandEvent.CONNECTED_EVENT, onConnected);
			_commandCenter.addEventListener(CommandEvent.IOERROR_EVENT, onIOError);
			_commandCenter.addEventListener(CommandEvent.SECURITYERROR_EVENT, onSecurityError);
			_commandCenter.connect(SocketContextConfig.server_ip, SocketContextConfig.server_port);
		}
		
		private function onClosed(event: CommandEvent): void
		{
			facade.removeCommand(CONNECT_SOCKET_NOTE);
		}
		
		private function onConnected(event: CommandEvent): void
		{
			facade.removeCommand(CONNECT_SOCKET_NOTE);
			facade.sendNotification(ServerMediator.DISPOSE_NOTE);
			facade.sendNotification(LoadSceneResourcesCommand.LOAD_RESOURCES_NOTE);
		}
		
		private function onIOError(event: CommandEvent): void
		{
			facade.removeCommand(CONNECT_SOCKET_NOTE);
		}
		
		private function onSecurityError(event: CommandEvent): void
		{
			facade.removeCommand(CONNECT_SOCKET_NOTE);
		}
	}
}