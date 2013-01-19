package proxy
{
	import controller.login.CreateStartMediatorCommand;
	import controller.scene.LoadSceneResourcesCommand;
	
	import mediator.PromptMediator;
	import mediator.loader.ProgressBarMediator;
	import mediator.login.ServerMediator;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import parameters.CServerListParameter;
	
	import utils.configuration.ConnectorContextConfig;
	import utils.events.LoaderEvent;
	import utils.language.LanguageManager;
	import utils.loader.ResourceLoadManager;
	import utils.loader.XMLLoader;
	import utils.network.CCommandCenter;
	import utils.network.command.CCommandList;
	
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
			
			ResourceLoadManager.load("config/" + LanguageManager.language + "/server_list.xml", false, "", onGetServerList);
		}
		
		private function onGetServerList(evt: LoaderEvent): void
		{
			var _config: XML = (evt.loader as XMLLoader).configXML;
			var _container: Vector.<CServerListParameter> = new Vector.<CServerListParameter>();
			
			for(var i: int = 0; i < _config.server.length(); i++)
			{
				var parameter: CServerListParameter = new CServerListParameter();
				parameter.id = _config.server[i].@id;
				parameter.name = _config.server[i].@name;
				parameter.ip = _config.server[i].@ip;
				parameter.port = _config.server[i].@port;
				parameter.recommand = _config.server[i].@recommand == "true";
				parameter.hot = _config.server[i].@hot == "true";
				_container.push(parameter);
			}
			setData(_container);
			
			sendNotification(PromptMediator.LOADING_HIDE_NOTE);
			sendNotification(ServerMediator.SHOW_SERVER_NOTE, _container);
			//sendNotification(LoadSceneResourcesCommand.LOAD_RESOURCES_NOTE);
			//发送通知 显示区服列表
		}
	}
}