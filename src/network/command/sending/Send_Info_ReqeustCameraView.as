package network.command.sending
{
	import utils.configuration.SocketContextConfig;
	import utils.network.command.sending.CNetPackageSending;
	
	/**
	 * ...
	 * @author johnnyeven
	 */
	public class Send_Info_ReqeustCameraView extends CNetPackageSending
	{
		public var posX: uint;
		public var posY: uint;
		
		public function Send_Info_ReqeustCameraView(controller:int, action:int)
		{
			super(SocketContextConfig.CONTROLLER_INFO, SocketContextConfig.ACTION_CAMERAVIEW_OBJECT_LIST);
		}
		
		override public function fill():void
		{
			super.fill();
			
			_byteArray.writeInt(4);
			_byteArray.writeInt(SocketContextConfig.TYPE_INT);
			_byteArray.writeInt(posX);
			
			_byteArray.writeInt(4);
			_byteArray.writeInt(SocketContextConfig.TYPE_INT);
			_byteArray.writeInt(posY);
		}
		
		override public function get protocolName():String
		{
			return "Send_Info_ReqeustCameraView";
		}
	}
}