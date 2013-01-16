package network.command.sending 
{
	import utils.network.command.sending.CNetPackageSending;
	import utils.configuration.SocketContextConfig;

	/**
	 * ...
	 * @author johnnyeven
	 */
	public class Send_Info_Login extends CNetPackageSending 
	{
		public var UserName: String;
		public var UserPass: String;
		
		public function Send_Info_Login() 
		{
			super(SocketContextConfig.CONTROLLER_INFO, SocketContextConfig.ACTION_LOGIN);
		}
		
		override public function fill():void 
		{
			super.fill();
			
			_byteArray.writeInt(UserName.length);
			_byteArray.writeByte(SocketContextConfig.TYPE_STRING);
			_byteArray.writeUTFBytes(UserName);
			
			_byteArray.writeInt(UserPass.length);
			_byteArray.writeByte(SocketContextConfig.TYPE_STRING);
			_byteArray.writeUTFBytes(UserPass);
		}
		
		override public function get protocolName():String
		{
			return "Send_Info_Login";
		}
	}

}