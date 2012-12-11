package network.command.sending 
{
	import utils.configuration.ConnectorContextConfig;
	import proxy.ServerListProxy;
	import utils.network.command.sending.CNetPackageSending;
	
	/**
	 * ...
	 * @author johnnyeven
	 */
	public class Send_Server_ServerList extends CNetPackageSending 
	{
		public var GameId: String;
		
		public function Send_Server_ServerList() 
		{
			super(ConnectorContextConfig.CONTROLLER_SERVER, ConnectorContextConfig.ACTION_SERVERLIST);
			flag = ServerListProxy.SERVER_LIST;
		}
		
		override public function fill():void 
		{
			super.fill();
			
			_urlVariables.game_id = GameId;
		}
	}

}