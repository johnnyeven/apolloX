package view.login
{
	import flash.display.DisplayObjectContainer;
	
	import utils.liteui.component.CaptionButton;
	import utils.liteui.component.Label;
	import utils.liteui.core.Component;
	import utils.resource.ResourcePool;
	
	public class ServerItemSelectedComponent extends Component
	{
		private var lblDelayTitle: Label;
		private var lblDelay: Label;
		private var btnEnter: CaptionButton;
		
		public function ServerItemSelectedComponent()
		{
			super(ResourcePool.getResource("ui.login.ServerItemSelectedSkin") as DisplayObjectContainer);
			
			lblDelayTitle = getUI(Label, "lblDelay") as Label;
			lblDelay = getUI(Label, "delay") as Label;
			btnEnter = getUI(CaptionButton, "btnEnter") as CaptionButton;
		}
	}
}