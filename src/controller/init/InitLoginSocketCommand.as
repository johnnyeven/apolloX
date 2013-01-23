package controller.init
{
	import controller.login.CreateStartMediatorCommand;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import utils.configuration.SocketContextConfig;
	import utils.events.CommandEvent;
	import utils.network.CCommandCenter;
	
	public class InitLoginSocketCommand extends SimpleCommand
	{
		public static const NAME: String = "InitLoginSocketCommand";
		public static const CONNECT_SOCKET_NOTE: String = "InitLoginSocketCommand.ConnectSocketNote";
		
		public function InitLoginSocketCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var _commandCenter: CCommandCenter = CCommandCenter.getInstance();
			_commandCenter.dispose();
			_commandCenter = CCommandCenter.getInstance();
			_commandCenter.addEventListener(CommandEvent.CLOSED_EVENT, onClosed);
			_commandCenter.addEventListener(CommandEvent.CONNECTED_EVENT, onConnected);
			_commandCenter.addEventListener(CommandEvent.IOERROR_EVENT, onIOError);
			_commandCenter.addEventListener(CommandEvent.SECURITYERROR_EVENT, onSecurityError);
			_commandCenter.connect(SocketContextConfig.login_ip, SocketContextConfig.login_port);
		}
		
		private function onClosed(event: CommandEvent): void
		{
			facade.removeCommand(CONNECT_SOCKET_NOTE);
		}
		
		private function onConnected(event: CommandEvent): void
		{
			facade.removeCommand(CONNECT_SOCKET_NOTE);
			facade.sendNotification(CreateStartMediatorCommand.CREATE_LOGIN_VIEW_NOTE);
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