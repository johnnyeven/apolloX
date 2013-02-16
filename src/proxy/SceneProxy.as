package proxy
{
	import network.command.receiving.Receive_Info_RequestCameraView;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import utils.network.CCommandCenter;
	import utils.network.command.CCommandList;
	
	public class SceneProxy extends Proxy implements IProxy
	{
		public static const NAME: String = "SceneProxy";
		
		public static const REQUEST_CAMERA_VIEW: uint = 0x0000;
		
		public function SceneProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		public function requestCurrentView(): void
		{
			CCommandList.getInstance().bind(REQUEST_CAMERA_VIEW, Receive_Info_RequestCameraView);
			CCommandCenter.getInstance().add(REQUEST_CAMERA_VIEW, onRequestCurrentView);
		}
		
		private function onRequestCurrentView(protocol: Receive_Info_RequestCameraView): void
		{
			setData(protocol);
			
			//TODO 显示RequestCameraView的对象
		}
	}
}