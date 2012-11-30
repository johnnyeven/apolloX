package view.scene.station.repair
{
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	import mediator.scene.station.RepairViewMediator;
	
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
			var _item1: RepairListItemComponent = new RepairListItemComponent();
			_container.add(_item1);
			var _item2: RepairListItemComponent = new RepairListItemComponent();
			_container.add(_item2);
			var _item3: RepairListItemComponent = new RepairListItemComponent();
			_container.add(_item3);
			var _item4: RepairListItemComponent = new RepairListItemComponent();
			_container.add(_item4);
			var _item5: RepairListItemComponent = new RepairListItemComponent();
			_container.add(_item5);
			
			_container.layout.update();
			_scrollBar.rebuild();
		}
	}
}