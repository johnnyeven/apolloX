package mediator.login
{
	import controller.init.LoadServerListCommand;
	
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	
	import parameters.CServerListParameter;
	
	import proxy.ServerListProxy;
	
	import utils.enum.PopupEffect;
	
	import view.login.ServerComponent;
	
	public class ServerMediator extends BaseMediator
	{
		public static const NAME: String = "ServerMediator";
		public static const SHOW_NOTE: String = "ServerMediator.ShowNote";
		public static const DISPOSE_NOTE: String = "ServerMediator.DisposeNote";
		public static const SHOW_SERVER_NOTE: String = "ServerMediator.ShowServerNote";
		
		public function ServerMediator()
		{
			super(NAME, new ServerComponent());
			component.mediator = this;
			_isPopUp = true;
			popUpEffect = PopupEffect.TOP;
			onShow = onShowCallback;
		}
		
		public function get component(): ServerComponent
		{
			return viewComponent as ServerComponent;
		}
		
		override public function listNotificationInterests():Array
		{
			return [SHOW_NOTE, DISPOSE_NOTE, SHOW_SERVER_NOTE];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case SHOW_NOTE:
					show();
					break;
				case DISPOSE_NOTE:
					dispose();
					break;
				case SHOW_SERVER_NOTE:
					showServerComponent();
					break;
			}
		}
		
		private function onShowCallback(_mediator: BaseMediator): void
		{
			sendNotification(LoadServerListCommand.LOAD_SERVERLIST_NOTE);
		}
		
		private function showServerComponent(): void
		{
			var _proxy: ServerListProxy = facade.retrieveProxy(ServerListProxy.NAME) as ServerListProxy;
			
			component.showServerList(_proxy.getData() as Vector.<CServerListParameter>);
		}
	}
}