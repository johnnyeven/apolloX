package view.login
{
	import flash.display.DisplayObjectContainer;
	
	import utils.liteui.component.Button;
	import utils.liteui.component.Label;
	import utils.liteui.core.Component;
	import utils.resource.ResourcePool;
	
	public class ServerComponent extends Component
	{
		private var _txtCaption: Label;
		private var _btnBack: Button;
		
		public function ServerComponent()
		{
			super(ResourcePool.getResource("ui.login.ServerWindowSkin") as DisplayObjectContainer);
			
			_txtCaption = getUI(Label, "caption") as Label;
			_btnBack = getUI(Button, "back") as Button;
			
			sortChildIndex();
		}
	}
}