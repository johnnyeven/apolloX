package view.scene.station
{
	import flash.display.DisplayObjectContainer;
	
	import utils.liteui.component.Button;
	import utils.liteui.core.Component;
	
	public class StationLeftMenuComponent extends Component
	{
		private var _btnLeft: Button;
		
		public function StationLeftMenuComponent(_skin:DisplayObjectContainer=null)
		{
			super(_skin);
			
			_btnLeft = getUI(Button, "btnLeft") as Button;
		}
	}
}