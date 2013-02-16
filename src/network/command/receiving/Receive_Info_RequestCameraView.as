package network.command.receiving
{
	import flash.utils.ByteArray;
	
	import utils.configuration.SocketContextConfig;
	import utils.network.command.receiving.CNetPackageReceiving;
	
	public class Receive_Info_RequestCameraView extends CNetPackageReceiving
	{
		public function Receive_Info_RequestCameraView(controller:int, action:int)
		{
			super(SocketContextConfig.CONTROLLER_INFO, SocketContextConfig.ACTION_CAMERAVIEW_OBJECT_LIST);
		}
		
		override public function fill(bytes:ByteArray):void
		{
			super.fill(bytes);
			
			if(message == SocketContextConfig.ACK_CONFIRM)
			{
				
			}
		}
	}
}