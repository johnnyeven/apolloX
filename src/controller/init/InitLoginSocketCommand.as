package controller.init
{
	import controller.login.CreateStartMediatorCommand;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import utils.configuration.SocketContextConfig;
	import utils.network.tcp.CNetSocket;
	
	public class InitLoginSocketCommand extends SimpleCommand
	{
		public static const NAME: String = "InitLoginSocketCommand";
		public static const CONNECT_SOCKET_NOTE: String = "InitLoginSocketCommand.ConnectSocketNote";
		
		private var _socket: CNetSocket;
		
		public function InitLoginSocketCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			_socket = CNetSocket.getInstance();
			_socket.addEventListener(Event.CLOSE, onClosed);
			_socket.addEventListener(Event.CONNECT, onConnected);
			_socket.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			_socket.connect(SocketContextConfig.login_ip, SocketContextConfig.login_port);
		}
		
		private function onClosed(event: Event): void
		{
			facade.removeCommand(CONNECT_SOCKET_NOTE);
			trace("服务器连接已断开");
		}
		
		private function onConnected(event: Event): void
		{
			trace("服务器已连接");
			facade.removeCommand(CONNECT_SOCKET_NOTE);
			sendNotification(CreateStartMediatorCommand.CREATE_LOGIN_VIEW_NOTE);
		}
		
		private function onIOError(event: IOErrorEvent): void
		{
			facade.removeCommand(CONNECT_SOCKET_NOTE);
			trace("无法连接至服务器");
		}
		
		private function onSecurityError(event: SecurityErrorEvent): void
		{
			facade.removeCommand(CONNECT_SOCKET_NOTE);
			trace("安全沙箱冲突");
		}
	}
}