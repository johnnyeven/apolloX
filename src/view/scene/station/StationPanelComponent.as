package view.scene.station
{
	import controller.scene.CreateAssemblyViewCommand;
	import controller.scene.CreateEnsureViewCommand;
	import controller.scene.CreateMedicalViewCommand;
	import controller.scene.CreateRepairViewCommand;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	import parameters.station.StationCharacterListParameter;
	
	import utils.enum.ScrollBarOrientation;
	import utils.liteui.component.Button;
	import utils.liteui.component.Container;
	import utils.liteui.component.Label;
	import utils.liteui.component.ScrollBar;
	import utils.liteui.component.ToggleButton;
	import utils.liteui.core.Component;
	import utils.liteui.layouts.FlowLayout;
	import utils.liteui.layouts.HorizontalTileLayout;
	import utils.resource.ResourcePool;
	
	public class StationPanelComponent extends Component
	{
		private var _lblStationName: Label;
		private var _btnAssembly: Button;
		private var _btnMarket: Button;
		private var _btnRepair: Button;
		private var _btnMedical: Button;
		private var _btnEnsure: Button;
		private var _scrollButton: ScrollBar;
		private var _containerButton: Container;
		private var _toggleDailiren: ToggleButton;
		private var _toggleGuest: ToggleButton;
		private var _containerDailiren: Container;
		private var _scrollDailiren: ScrollBar;
		
		public function StationPanelComponent(_skin:DisplayObjectContainer=null)
		{
			super(_skin);
			
			_lblStationName = getUI(Label, "stationName") as Label;
			_btnAssembly = getUIByDisplay(Button, ResourcePool.getResource("assets.scene1Station.panel.BtnAssembly")) as Button;
			_btnMarket = getUIByDisplay(Button, ResourcePool.getResource("assets.scene1Station.panel.BtnMarket")) as Button;
			_btnRepair = getUIByDisplay(Button, ResourcePool.getResource("assets.scene1Station.panel.BtnRepair")) as Button;
			_btnMedical = getUIByDisplay(Button, ResourcePool.getResource("assets.scene1Station.panel.BtnMedical")) as Button;
			_btnEnsure = getUIByDisplay(Button, ResourcePool.getResource("assets.scene1Station.panel.BtnEnsure")) as Button;
			
			_containerButton = new Container();
			_containerButton.x = 31;
			_containerButton.y = 62;
			_containerButton.contentWidth = 316;
			_containerButton.contentHeight = 202;
			_containerButton.layout = new FlowLayout(_containerButton);
			_containerButton.layout.vGap = 12;
			_containerButton.layout.hGap = 12;
			addChild(_containerButton);
			
			_scrollButton = getUI(ScrollBar, "btnScroll") as ScrollBar;
			_scrollButton.orientation = ScrollBarOrientation.VERTICAL;
			_scrollButton.view = _containerButton;
			
			_toggleDailiren = getUI(ToggleButton, "dailirenToggleButton") as ToggleButton;
			_toggleGuest = getUI(ToggleButton, "guestToggleButton") as ToggleButton;
			
			_btnAssembly.addEventListener(MouseEvent.MOUSE_UP, onBtnAssemblyClick);
			_btnRepair.addEventListener(MouseEvent.MOUSE_UP, onBtnRepairClick);
			_btnMedical.addEventListener(MouseEvent.MOUSE_UP, onBtnMedicalClick);
			_btnEnsure.addEventListener(MouseEvent.MOUSE_UP, onBtnEnsureClick);
			
			_toggleDailiren.caption = "代理人";
			_toggleGuest.caption = "访客";
			_toggleDailiren.toggle = true;
			
			_toggleDailiren.addEventListener(MouseEvent.CLICK, onDailirenClick);
			_toggleGuest.addEventListener(MouseEvent.CLICK, onGuestClick);
			
			_containerDailiren = new Container();
			_containerDailiren.x = 25;
			_containerDailiren.y = 330;
			_containerDailiren.contentWidth = 322;
			_containerDailiren.contentHeight = 250;
			_containerDailiren.layout = new HorizontalTileLayout(_containerDailiren);
			addChild(_containerDailiren);
			
			_scrollDailiren = getUI(ScrollBar, "dailirenScroll") as ScrollBar;
			_scrollDailiren.orientation = ScrollBarOrientation.VERTICAL;
			_scrollDailiren.view = _containerDailiren;
			
			sortChildIndex();
			addChild(_scrollDailiren);
			addChild(_scrollButton);
			
			//空间站服务按钮
			_containerButton.add(_btnAssembly);
			_containerButton.add(_btnMarket);
			_containerButton.add(_btnRepair);
			_containerButton.add(_btnMedical);
			_containerButton.add(_btnEnsure);
			
			_containerButton.layout.update();
			_scrollButton.rebuild();
			
			var parameter: StationCharacterListParameter = new StationCharacterListParameter();
			parameter.fill({
				avatar: "",
				username: "无敌小星",
				userdesc: "啊斯蒂芬"
			});
			var item: StationPanelListComponent = new StationPanelListComponent();
			item.info = parameter;
			_containerDailiren.add(item);
			
			var item1: StationPanelListComponent = new StationPanelListComponent();
			item1.info = parameter;
			_containerDailiren.add(item1);
			
			var item2: StationPanelListComponent = new StationPanelListComponent();
			item2.info = parameter;
			_containerDailiren.add(item2);
			
			var item3: StationPanelListComponent = new StationPanelListComponent();
			item3.info = parameter;
			_containerDailiren.add(item3);
			
			var item4: StationPanelListComponent = new StationPanelListComponent();
			item4.info = parameter;
			_containerDailiren.add(item4);
			
			var item5: StationPanelListComponent = new StationPanelListComponent();
			item5.info = parameter;
			_containerDailiren.add(item5);
			
			_containerDailiren.layout.update();
			_scrollDailiren.rebuild();
		}
		
		private function onDailirenClick(evt: MouseEvent): void
		{
			_toggleDailiren.toggle = true;
			_toggleGuest.toggle = false;
		}
		
		private function onGuestClick(evt: MouseEvent): void
		{
			_toggleDailiren.toggle = false;
			_toggleGuest.toggle = true;
		}
		
		private function onBtnAssemblyClick(evt: MouseEvent): void
		{
			ApplicationFacade.getInstance().sendNotification(CreateAssemblyViewCommand.LOAD_ASSEMBLY_VIEW_NOTE);
		}
		
		private function onBtnRepairClick(evt: MouseEvent): void
		{
			ApplicationFacade.getInstance().sendNotification(CreateRepairViewCommand.LOAD_REPAIR_VIEW_NOTE);
		}
		
		private function onBtnMedicalClick(evt: MouseEvent): void
		{
			ApplicationFacade.getInstance().sendNotification(CreateMedicalViewCommand.LOAD_MEDICAL_VIEW_NOTE);
		}
		
		private function onBtnEnsureClick(evt: MouseEvent): void
		{
			ApplicationFacade.getInstance().sendNotification(CreateEnsureViewCommand.LOAD_ENSURE_VIEW_NOTE);
		}
	}
}