package network.command.sending 
{
	import utils.configuration.SocketContextConfig;
	import proxy.LoginProxy;
	import utils.network.command.sending.CNetPackageSending;
	
	/**
	 * ...
	 * @author johnnyeven
	 */
	public class Send_Info_QuickStart extends CNetPackageSending 
	{
		public var GameId: int;
		
		public function Send_Info_QuickStart() 
		{
			super(SocketContextConfig.CONTROLLER_INFO, SocketContextConfig.ACTION_QUICK_START);
		}
		
		override public function fill():void 
		{
			super.fill();
			
			_byteArray.writeInt(4);
			_byteArray.writeByte(SocketContextConfig.TYPE_INT);
			_byteArray.writeInt(GameId);
		}
	}

}