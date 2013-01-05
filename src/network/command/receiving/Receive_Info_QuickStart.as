package network.command.receiving 
{
	import flash.utils.ByteArray;
	
	import utils.StringUtils;
	import utils.configuration.SocketContextConfig;
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
			super(SocketContextConfig.CONTROLLER_INFO, SocketContextConfig.ACTION_QUICK_START);
		}
		
		override public function fill(bytes: ByteArray):void
		{
			super.fill(bytes);
			
			if (message == SocketContextConfig.ACK_CONFIRM)
			{
				var length: int;
				var type: int;
				while (bytes.bytesAvailable)
				{
					length = bytes.readInt();
					type = bytes.readByte();
					switch(type)
					{
						case SocketContextConfig.TYPE_STRING:
							if (StringUtils.empty(GUID))
							{
								GUID = bytes.readUTFBytes(length);
							}
							break;
					}
				}
			}
		}
	}

}