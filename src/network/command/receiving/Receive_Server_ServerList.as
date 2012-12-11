package network.command.receiving 
{
	import utils.configuration.ConnectorContextConfig;
	import utils.network.command.receiving.CNetPackageReceiving;
	
	/**
	 * ...
	 * @author john
	 */
	public class Receive_Server_ServerList extends CNetPackageReceiving 
	{
		public var ServerList: Array;
		
		private const MESSAGE_SERVERLIST_SUCCESS: int = 1;
		
		public function Receive_Server_ServerList() 
		{
			super(ConnectorContextConfig.CONTROLLER_SERVER, ConnectorContextConfig.ACTION_SERVERLIST);
		}
		
		override public function fill(data: Object): void 
		{
			super.fill(data);
			
			if (message == MESSAGE_SERVERLIST_SUCCESS)
			{
				ServerList = data.server;
			}
		}
	}

}