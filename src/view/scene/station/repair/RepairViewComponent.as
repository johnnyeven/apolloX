package view.scene.station.repair
{
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	import mediator.scene.station.RepairViewMediator;
	
	import parameters.station.RepairItemListParameter;
	
	import utils.enum.ScrollBarOrientation;
	import utils.liteui.component.Button;
	import utils.liteui.component.Container;
	import utils.liteui.component.Label;
	import utils.liteui.component.ScrollBar;
	import utils.liteui.core.Component;
	import utils.liteui.layouts.HorizontalTileLayout;
	import utils.resource.ResourcePool;
	
	public class RepairViewComponent extends Component
	{
		private var _btnClose: Button;
		private var _caption: Label;
		private var _lblShipNameLabel: Label;
		private var _lblDamageLabel: Label;
		private var _lblRepairCostLabel: Label;
		private var _lblControlLabel: Label;
		private var _container: Container;
		private var _scrollBar: ScrollBar;
		
		public function RepairViewComponent()
		{
			super(ResourcePool.getResource("assets.scene1Station.repair.view") as DisplayObjectContainer);
			
			_btnClose = getUI(Button, "btnClose") as Button;
			_caption = getUI(Label, "caption") as Label;
			_lblShipNameLabel = getUI(Label, "lblShipName") as Label;
			_lblDamageLabel = getUI(Label, "lblDamage") as Label;
			_lblRepairCostLabel = getUI(Label, "lblRepairCost") as Label;
			_lblControlLabel = getUI(Label, "lblControl") as Label;
			
			_container = new Container();
			_container.x = 23;
			_container.y = 100;
			_container.contentWidth = 659;
			_container.contentHeight = 332;
			_container.layout = new HorizontalTileLayout(_container);
			addChild(_container);
			
			_scrollBar = getUI(ScrollBar, "scrollBar") as ScrollBar;
			_scrollBar.orientation = ScrollBarOrientation.VERTICAL;
			_scrollBar.view = _container;
			
			sortChildIndex();
			addChild(_scrollBar);
			
			_caption.text = "维修厂";
			_btnClose.addEventListener(MouseEvent.CLICK, onBtnCloseClick);
		}
		
		private function onBtnCloseClick(evt: MouseEvent): void
		{
			ApplicationFacade.getInstance().sendNotification(RepairViewMediator.REPAIR_DISPOSE_NOTE);
		}
		
		public function showListComponent(): void
		{
			var parameter: RepairItemListParameter = new RepairItemListParameter();
			parameter.avatar = "resources/assets/small_avatar.png";
			parameter.shipName = "突击者级";
			parameter.currentSheild = 8273;
			parameter.currentArmor = 7263;
			parameter.currentConstruct = 11502;
			parameter.maxSheild = 8273;
			parameter.maxArmor = 9805;
			parameter.maxConstruct = 11502;
			parameter.cost = 112856;
			var _item: RepairListItemComponent = new RepairListItemComponent();
			_item.info = parameter;
			_container.add(_item);
			
			parameter = new RepairItemListParameter();
			parameter.avatar = "resources/assets/small_avatar.png";
			parameter.shipName = "进化者级";
			parameter.currentSheild = 5273;
			parameter.currentArmor = 763;
			parameter.currentConstruct = 11502;
			parameter.maxSheild = 8273;
			parameter.maxArmor = 9805;
			parameter.maxConstruct = 11502;
			parameter.cost = 6411502;
			_item = new RepairListItemComponent();
			_item.info = parameter;
			_container.add(_item);
			
			parameter = new RepairItemListParameter();
			parameter.avatar = "resources/assets/small_avatar.png";
			parameter.shipName = "地狱天使级";
			parameter.currentSheild = 5273;
			parameter.currentArmor = 763;
			parameter.currentConstruct = 9800;
			parameter.maxSheild = 10273;
			parameter.maxArmor = 19805;
			parameter.maxConstruct = 9800;
			parameter.cost = 112856;
			_item = new RepairListItemComponent();
			_item.info = parameter;
			_container.add(_item);
			
			parameter = new RepairItemListParameter();
			parameter.avatar = "resources/assets/small_avatar.png";
			parameter.shipName = "帕拉丁级";
			parameter.currentSheild = 20459;
			parameter.currentArmor = 19800;
			parameter.currentConstruct = 15000;
			parameter.maxSheild = 20459;
			parameter.maxArmor = 19800;
			parameter.maxConstruct = 15000;
			parameter.cost = 0;
			_item = new RepairListItemComponent();
			_item.info = parameter;
			_container.add(_item);
			
			_container.layout.update();
			_scrollBar.rebuild();
		}
	}
}