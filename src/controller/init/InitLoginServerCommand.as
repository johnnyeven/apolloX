package controller.init
{
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import utils.configuration.SocketContextConfig;
	import utils.events.LoaderEvent;
	import utils.language.LanguageManager;
	import utils.loader.ResourceLoadManager;
	import utils.loader.XMLLoader;
	
	public class InitLoginServerCommand extends SimpleCommand
	{
		public static const NAME: String = "InitLoginServerCommand";
		public static const LOAD_SERVER_NOTE: String = "InitLoginServerCommand.LoadServerNote";
		
		public function InitLoginServerCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			ResourceLoadManager.load("config/" + LanguageManager.language + "/login_server.xml", false, "", onLoginServerLoaded);
		}
		
		private function onLoginServerLoaded(evt: LoaderEvent): void
		{
			var _config: XML = (evt.loader as XMLLoader).configXML;
			
			if(_config.hasOwnProperty("server"))
			{
				SocketContextConfig.login_ip = _config.server[0].@ip;
				SocketContextConfig.login_port = parseInt(_config.server[0].@port);
			}
			
			facade.removeCommand(LOAD_SERVER_NOTE);
			facade.registerCommand(InitLoginSocketCommand.CONNECT_SOCKET_NOTE, InitLoginSocketCommand);
			facade.sendNotification(InitLoginSocketCommand.CONNECT_SOCKET_NOTE);
		}
	}
}