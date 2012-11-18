package view.scene.station
{
	import flash.display.DisplayObjectContainer;
	
	import utils.liteui.component.Label;
	import utils.liteui.component.ToggleButton;
	import utils.liteui.core.Component;
	
	public class StationPanelComponent extends Component
	{
		private var _lblStationName: Label;
		private var _toggleDailiren: ToggleButton;
		private var _toggleGuest: ToggleButton;
		
		public function StationPanelComponent(_skin:DisplayObjectContainer=null)
		{
			super(_skin);
			
			_lblStationName = getUI(Label, "stationName") as Label;
			_toggleDailiren = getUI(ToggleButton, "dailirenToggleButton") as ToggleButton;
			_toggleGuest = getUI(ToggleButton, "guestToggleButton") as ToggleButton;
			
			sortChildIndex();
			
			_toggleDailiren.caption = "代理人";
			_toggleGuest.caption = "访客";
			_toggleDailiren.toggle = true;
		}
	}
}