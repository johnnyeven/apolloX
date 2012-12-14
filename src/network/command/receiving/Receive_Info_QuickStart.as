package network.command.receiving 
{
	import utils.configuration.ConnectorContextConfig;
	import utils.network.command.receiving.CNetPackageReceiving;
	
	/**
	 * ...
	 * @author john
	 */
	public class Receive_Info_QuickStart extends CNetPackageReceiving 
	{
		public var GUID: String = "";
		
		public function Receive_Info_QuickStart() 
		{
			super(ConnectorContextConfig.CONTROLLER_INFO, ConnectorContextConfig.ACTION_QUICK_START);
		}
		
		override public function fill(data: Object): void 
		{
			super.fill(data);
			
			if (message == ConnectorContextConfig.ACK_CONFIRM)
			{
				GUID = data.guid;
			}
		}
	}

}