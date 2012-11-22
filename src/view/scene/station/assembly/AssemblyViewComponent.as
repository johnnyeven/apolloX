package view.scene.station.assembly
{
	import flash.display.DisplayObjectContainer;
	
	import utils.liteui.component.Button;
	import utils.liteui.component.Label;
	import utils.liteui.core.Component;
	import utils.resource.ResourcePool;
	
	public class AssemblyViewComponent extends Component
	{
		private var _btnClose: Button;
		private var _caption: Label;
		
		public function AssemblyViewComponent()
		{
			super(ResourcePool.getResource("assets.scene1Station.assembly.view") as DisplayObjectContainer);
			
			_btnClose = getUI(Button, "btnClose") as Button;
			_caption = getUI(Label, "caption") as Label;
			
			sortChildIndex();
			
			_caption.text = "装配工厂";
		}
	}
}