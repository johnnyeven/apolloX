package controller.init
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import parameters.CServerListParameter;
	
	import utils.configuration.SocketContextConfig;
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
			facade.removeCommand(CONNECT_SOCKET_NOTE);
			var _parameter: CServerListParameter = notification.getBody() as CServerListParameter;
			
			if(_parameter != null)
			{
				SocketContextConfig.server_ip = _parameter.ip;
				SocketContextConfig.server_port = _parameter.port;
			}
			
			CCommandCenter.getInstance().dispose();
			CCommandCenter.getInstance().connect(SocketContextConfig.server_ip, SocketContextConfig.server_port);
		}
	}
}