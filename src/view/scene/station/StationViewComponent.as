package view.scene.station
{
	import flash.display.DisplayObjectContainer;
	
	import utils.liteui.core.Component;
	import utils.resource.ResourcePool;
	
	public class StationViewComponent extends Component
	{
		private var stationLeftMenu: StationLeftMenuComponent;
		private var stationOverview: StationOverviewComponent;
		private var stationPanel: StationPanelComponent;
		
		public function StationViewComponent()
		{
			super(ResourcePool.getResource("assets.scene1Station.View") as DisplayObjectContainer);
			
			stationLeftMenu = getUI(StationLeftMenuComponent, "menu") as StationLeftMenuComponent;
			stationOverview = getUI(StationOverviewComponent, "overview") as StationOverviewComponent;
			stationPanel = getUI(StationPanelComponent, "panel") as StationPanelComponent;
			
			sortChildIndex();
		}
	}
}