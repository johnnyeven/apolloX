package utils.network.command.receiving 
{
	import configuration.ConnectorContextConfig;
	
	/**
	 * ...
	 * @author john
	 */
	public class Receive_Info_Login extends CNetPackageReceiving 
	{
		public var GUID: String = "";
		
		public function Receive_Info_Login() 
		{
			super(ConnectorContextConfig.CONTROLLER_INFO, ConnectorContextConfig.ACTION_LOGIN);
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