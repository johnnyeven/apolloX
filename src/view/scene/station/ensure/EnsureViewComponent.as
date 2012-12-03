package view.scene.station.ensure
{
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	import mediator.scene.station.EnsureViewMediator;
	
	import parameters.station.EnsureItemListParameter;
	
	import utils.enum.ScrollBarOrientation;
	import utils.liteui.component.Button;
	import utils.liteui.component.Container;
	import utils.liteui.component.Label;
	import utils.liteui.component.ScrollBar;
	import utils.liteui.core.Component;
	import utils.liteui.layouts.HorizontalTileLayout;
	import utils.resource.ResourcePool;
	
	import view.scene.station.ensure.EnsureListItemComponent;
	
	public class EnsureViewComponent extends Component
	{
		private var _btnClose: Button;
		private var _caption: Label;
		private var _lblShipNameLabel: Label;
		private var _lblLevelLabel: Label;
		private var _lblEndTimeLabel: Label;
		private var _lblControlLabel: Label;
		private var _container: Container;
		private var _scrollBar: ScrollBar;
		
		public function EnsureViewComponent()
		{
			super(ResourcePool.getResource("assets.scene1Station.ensure.view") as DisplayObjectContainer);
			
			_btnClose = getUI(Button, "btnClose") as Button;
			_caption = getUI(Label, "caption") as Label;
			_lblShipNameLabel = getUI(Label, "lblShipName") as Label;
			_lblLevelLabel = getUI(Label, "lblLevel") as Label;
			_lblEndTimeLabel = getUI(Label, "lblEndTime") as Label;
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
			
			_btnClose.addEventListener(MouseEvent.CLICK, onBtnCloseClick);
		}
		
		private function onBtnCloseClick(evt: MouseEvent): void
		{
			ApplicationFacade.getInstance().sendNotification(EnsureViewMediator.ENSURE_DISPOSE_NOTE);
		}
		
		public function showListComponent(): void
		{
			var parameter: EnsureItemListParameter = new EnsureItemListParameter();
			parameter.avatar = "resources/assets/small_avatar.png";
			parameter.shipName = "突击者级";
			parameter.level = 0;
			parameter.endTime = 0;
			var item: EnsureListItemComponent = new EnsureListItemComponent();
			item.info = parameter;
			_container.add(item);
			
			parameter = new EnsureItemListParameter();
			parameter.avatar = "resources/assets/small_avatar.png";
			parameter.shipName = "惩罚者级";
			parameter.level = 2;
			parameter.endTime = 135489073;
			item = new EnsureListItemComponent();
			item.info = parameter;
			_container.add(item);
			
			parameter = new EnsureItemListParameter();
			parameter.avatar = "resources/assets/small_avatar.png";
			parameter.shipName = "惩罚者级";
			parameter.level = 2;
			parameter.endTime = 135489073;
			item = new EnsureListItemComponent();
			item.info = parameter;
			_container.add(item);
			
			parameter = new EnsureItemListParameter();
			parameter.avatar = "resources/assets/small_avatar.png";
			parameter.shipName = "惩罚者级";
			parameter.level = 2;
			parameter.endTime = 135489073;
			item = new EnsureListItemComponent();
			item.info = parameter;
			_container.add(item);
			
			parameter = new EnsureItemListParameter();
			parameter.avatar = "resources/assets/small_avatar.png";
			parameter.shipName = "惩罚者级";
			parameter.level = 2;
			parameter.endTime = 135489073;
			item = new EnsureListItemComponent();
			item.info = parameter;
			_container.add(item);
			
			parameter = new EnsureItemListParameter();
			parameter.avatar = "resources/assets/small_avatar.png";
			parameter.shipName = "惩罚者级";
			parameter.level = 2;
			parameter.endTime = 135489073;
			item = new EnsureListItemComponent();
			item.info = parameter;
			_container.add(item);
			
			parameter = new EnsureItemListParameter();
			parameter.avatar = "resources/assets/small_avatar.png";
			parameter.shipName = "惩罚者级";
			parameter.level = 2;
			parameter.endTime = 135489073;
			item = new EnsureListItemComponent();
			item.info = parameter;
			_container.add(item);
			
			parameter = new EnsureItemListParameter();
			parameter.avatar = "resources/assets/small_avatar.png";
			parameter.shipName = "惩罚者级";
			parameter.level = 2;
			parameter.endTime = 135489073;
			item = new EnsureListItemComponent();
			item.info = parameter;
			_container.add(item);
			
			parameter = new EnsureItemListParameter();
			parameter.avatar = "resources/assets/small_avatar.png";
			parameter.shipName = "惩罚者级";
			parameter.level = 2;
			parameter.endTime = 135489073;
			item = new EnsureListItemComponent();
			item.info = parameter;
			_container.add(item);
			
			parameter = new EnsureItemListParameter();
			parameter.avatar = "resources/assets/small_avatar.png";
			parameter.shipName = "惩罚者级";
			parameter.level = 2;
			parameter.endTime = 135489073;
			item = new EnsureListItemComponent();
			item.info = parameter;
			_container.add(item);
			
			parameter = new EnsureItemListParameter();
			parameter.avatar = "resources/assets/small_avatar.png";
			parameter.shipName = "惩罚者级";
			parameter.level = 2;
			parameter.endTime = 135489073;
			item = new EnsureListItemComponent();
			item.info = parameter;
			_container.add(item);
			
			parameter = new EnsureItemListParameter();
			parameter.avatar = "resources/assets/small_avatar.png";
			parameter.shipName = "惩罚者级";
			parameter.level = 2;
			parameter.endTime = 135489073;
			item = new EnsureListItemComponent();
			item.info = parameter;
			_container.add(item);
			
			parameter = new EnsureItemListParameter();
			parameter.avatar = "resources/assets/small_avatar.png";
			parameter.shipName = "惩罚者级";
			parameter.level = 2;
			parameter.endTime = 135489073;
			item = new EnsureListItemComponent();
			item.info = parameter;
			_container.add(item);
			
			parameter = new EnsureItemListParameter();
			parameter.avatar = "resources/assets/small_avatar.png";
			parameter.shipName = "惩罚者级";
			parameter.level = 2;
			parameter.endTime = 135489073;
			item = new EnsureListItemComponent();
			item.info = parameter;
			_container.add(item);
			
			parameter = new EnsureItemListParameter();
			parameter.avatar = "resources/assets/small_avatar.png";
			parameter.shipName = "惩罚者级";
			parameter.level = 2;
			parameter.endTime = 135489073;
			item = new EnsureListItemComponent();
			item.info = parameter;
			_container.add(item);
			
			parameter = new EnsureItemListParameter();
			parameter.avatar = "resources/assets/small_avatar.png";
			parameter.shipName = "惩罚者级";
			parameter.level = 2;
			parameter.endTime = 135489073;
			item = new EnsureListItemComponent();
			item.info = parameter;
			_container.add(item);
			
			parameter = new EnsureItemListParameter();
			parameter.avatar = "resources/assets/small_avatar.png";
			parameter.shipName = "惩罚者级";
			parameter.level = 2;
			parameter.endTime = 135489073;
			item = new EnsureListItemComponent();
			item.info = parameter;
			_container.add(item);
			
			parameter = new EnsureItemListParameter();
			parameter.avatar = "resources/assets/small_avatar.png";
			parameter.shipName = "惩罚者级";
			parameter.level = 2;
			parameter.endTime = 135489073;
			item = new EnsureListItemComponent();
			item.info = parameter;
			_container.add(item);
			
			parameter = new EnsureItemListParameter();
			parameter.avatar = "resources/assets/small_avatar.png";
			parameter.shipName = "惩罚者级";
			parameter.level = 2;
			parameter.endTime = 135489073;
			item = new EnsureListItemComponent();
			item.info = parameter;
			_container.add(item);
			
			parameter = new EnsureItemListParameter();
			parameter.avatar = "resources/assets/small_avatar.png";
			parameter.shipName = "惩罚者级";
			parameter.level = 2;
			parameter.endTime = 135489073;
			item = new EnsureListItemComponent();
			item.info = parameter;
			_container.add(item);
			
			_container.layout.update();
			_scrollBar.rebuild();
		}
	}
}