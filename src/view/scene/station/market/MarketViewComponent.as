package view.scene.station.market
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import mediator.scene.station.MarketViewMediator;
	
	import parameters.station.MarketItemListParameter;
	
	import utils.events.TreeEvent;
	import utils.liteui.component.Button;
	import utils.liteui.component.CaptionButton;
	import utils.liteui.component.Container;
	import utils.liteui.component.ImageContainer;
	import utils.liteui.component.Label;
	import utils.liteui.component.ScrollBar;
	import utils.liteui.component.TreeNode;
	import utils.liteui.component.TreeView;
	import utils.liteui.core.Component;
	import utils.liteui.layouts.HorizontalTileLayout;
	import utils.resource.ResourcePool;
	
	public class MarketViewComponent extends Component
	{
		private var _btnClose: Button;
		private var _caption: Label;
		private var _btnQuery: CaptionButton;
		private var _textQuery: TextField;
		private var _lblStandby1: Label;
		private var _lblStandby2: Label;
		private var _btnBuy: CaptionButton;
		private var _avatar: ImageContainer;
		private var _infoIcon: MovieClip;
		private var _lblPosition: Label;
		private var _lblItemName: Label;
		private var _lblStation1: Label;
		private var _lblStation2: Label;
		private var _lblCount1: Label;
		private var _lblCount2: Label;
		private var _lblCost1: Label;
		private var _lblCost2: Label;
		private var _lblTime1: Label;
		private var _lblTime2: Label;
		private var _containerSell: Container;
		private var _containerBuy: Container;
		private var _scrollSell: ScrollBar;
		private var _scrollBuy: ScrollBar;
		
		public function MarketViewComponent()
		{
			super(ResourcePool.getResource("assets.scene1Station.market.view") as DisplayObjectContainer);
			
			_btnClose = getUI(Button, "btnClose") as Button;
			_caption = getUI(Label, "caption") as Label;
			_btnQuery = getUI(CaptionButton, "btnQuery") as CaptionButton;
			_lblStandby1 = getUI(Label, "lblStandby1") as Label;
			_lblStandby2 = getUI(Label, "lblStandby2") as Label;
			_btnBuy = getUI(CaptionButton, "btnBuy") as CaptionButton;
			_avatar = getUI(ImageContainer, "avatar") as ImageContainer;
			_lblPosition = getUI(Label, "lblPosition") as Label;
			_lblItemName = getUI(Label, "lblItemName") as Label;
			_lblStation1 = getUI(Label, "lblStation1") as Label;
			_lblStation2 = getUI(Label, "lblStation2") as Label;
			_lblCount1 = getUI(Label, "lblCount1") as Label;
			_lblCount2 = getUI(Label, "lblCount2") as Label;
			_lblCost1 = getUI(Label, "lblCost1") as Label;
			_lblCost2 = getUI(Label, "lblCost2") as Label;
			_lblTime1 = getUI(Label, "lblTime1") as Label;
			_lblTime2 = getUI(Label, "lblTime2") as Label;
			_infoIcon = getSkin("infoIcon") as MovieClip;
			_scrollSell = getUI(ScrollBar, "scrollSell") as ScrollBar;
			_scrollBuy = getUI(ScrollBar, "scrollBuy") as ScrollBar;
			
			sortChildIndex();
			
			_btnClose.addEventListener(MouseEvent.CLICK, onBtnCloseClick);
			_btnBuy.visible = false;
			
			_avatar.source = "resources/assets/230_64.png";
			
			_textQuery = new TextField();
			var _textFormat: TextFormat = new TextFormat();
			_textFormat.align = TextFieldAutoSize.LEFT;
			_textFormat.color = 0x00CCFF;
			_textFormat.font = "宋体";
			_textFormat.size = 12;
			_textQuery.type = TextFieldType.INPUT;
			_textQuery.defaultTextFormat = _textFormat;
			_textQuery.text = "请输入查询关键字...";
			_textQuery.x = 53;
			_textQuery.y = 113;
			_textQuery.width = 164;
			_textQuery.addEventListener(FocusEvent.FOCUS_IN, onTextActive);
			_textQuery.addEventListener(FocusEvent.FOCUS_OUT, onTextDeactive);
			addChild(_textQuery);
			
			_containerSell = new Container();
			_containerSell.contentWidth = 623;
			_containerSell.contentHeight = 135;
			_containerSell.x = 364;
			_containerSell.y = 190;
			_containerSell.layout = new HorizontalTileLayout(_containerSell);
			_scrollSell.view = _containerSell;
			addChild(_containerSell);
			addChild(_scrollSell);
			
			_containerBuy = new Container();
			_containerBuy.contentWidth = 623;
			_containerBuy.contentHeight = 135;
			_containerBuy.x = 364;
			_containerBuy.y = 407;
			_containerBuy.layout = new HorizontalTileLayout(_containerBuy);
			_scrollBuy.view = _containerBuy;
			addChild(_containerBuy);
			addChild(_scrollBuy);
			
			hideInfo();
		}
		
		public function hideInfo(): void
		{
			_infoIcon.visible = false;
			_avatar.visible = false;
			_lblPosition.visible = false;
			_lblItemName.visible = false;
			_containerSell.visible = false;
			_scrollSell.visible = false;
			_containerBuy.visible = false;
			_scrollBuy.visible = false;
			_lblStandby1.visible = true;
			_lblStandby2.visible = true;
		}
		
		public function showInfo(): void
		{
			_infoIcon.visible = true;
			_avatar.visible = true;
			_lblPosition.visible = true;
			_lblItemName.visible = true;
			_containerSell.visible = true;
			_scrollSell.visible = true;
			_containerBuy.visible = true;
			_scrollBuy.visible = true;
			_lblStandby1.visible = false;
			_lblStandby2.visible = false;
		}
		
		private function onTextActive(evt: Event): void
		{
			if(_textQuery.text == "请输入查询关键字...")
			{
				_textQuery.text = "";
			}
		}
		
		private function onTextDeactive(evt: Event): void
		{
			if(_textQuery.text == "")
			{
				_textQuery.text = "请输入查询关键字...";
			}
		}
		
		private function onBtnCloseClick(evt: MouseEvent): void
		{
			ApplicationFacade.getInstance().sendNotification(MarketViewMediator.MARKET_DISPOSE_NOTE);
		}
		
		public function showComponent(): void
		{
			var tree: TreeView = new TreeView();
			tree.x = 41;
			tree.y = 145;
			tree.width = 286;
			tree.height = 392;
			
			addChild(tree);
			tree.addEventListener(TreeEvent.TREE_NODE_CLICK, onTreeNodeClick);
			
			var item: TreeNode = new TreeNode();
			item.caption = "测试一下";
			tree.add(item);
			
			var item1: TreeNode = new TreeNode();
			item1.caption = "123";
			tree.add(item1);
			
			var sub: TreeNode = new TreeNode();
			sub.caption = "youlaiyoulai";
			item1.add(sub);
			
			sub = new TreeNode();
			sub.caption = "uykyuiyuti";
			item.add(sub);
			sub = new TreeNode();
			sub.caption = "uykyuiyuti";
			item.add(sub);
			sub = new TreeNode();
			sub.caption = "uykyuiyuti";
			item1.add(sub);
			
			var sub1: TreeNode = new TreeNode();
			sub1.caption = "youlaiyoulai";
			sub.add(sub1);
			
			var sub2: TreeNode = new TreeNode();
			sub2.caption = "youlaiyoulai123";
			sub1.add(sub2);
			
			sub2 = new TreeNode();
			sub2.caption = "youlaiyoulai123";
			sub1.add(sub2);
			sub2 = new TreeNode();
			sub2.caption = "youlaiyoulai123";
			sub1.add(sub2);
			sub2 = new TreeNode();
			sub2.caption = "youlaiyoulai123";
			sub1.add(sub2);
			sub2 = new TreeNode();
			sub2.caption = "youlaiyoulai123";
			sub1.add(sub2);
			
			tree.update();
		}
		
		public function showListComponent(): void
		{
			_containerSell.removeAll();
			_containerBuy.removeAll();
			
			var parameter: MarketItemListParameter = new MarketItemListParameter();
			parameter.id = 10001;
			parameter.stationName = "奥尔萨里 - 艾玛海军 III 装配工厂 - 月形联合总部";
			parameter.itemCount = 100;
			parameter.itemCost = 120000;
			parameter.endTime = 135450023;
			var item: MarketListItemViewComponent = new MarketListItemViewComponent();
			item.info = parameter;
			_containerSell.add(item);
			
			parameter = new MarketItemListParameter();
			parameter.id = 10001;
			parameter.stationName = "奥尔萨里 - 艾玛海军 III 装配工厂 - 月形联合总部";
			parameter.itemCount = 100;
			parameter.itemCost = 120000;
			parameter.endTime = 135450023;
			item = new MarketListItemViewComponent();
			item.info = parameter;
			_containerSell.add(item);
			
			parameter = new MarketItemListParameter();
			parameter.id = 10001;
			parameter.stationName = "奥尔萨里 - 艾玛海军 III 装配工厂 - 月形联合总部";
			parameter.itemCount = 100;
			parameter.itemCost = 120000;
			parameter.endTime = 135450023;
			item = new MarketListItemViewComponent();
			item.info = parameter;
			_containerSell.add(item);
			
			parameter = new MarketItemListParameter();
			parameter.id = 10001;
			parameter.stationName = "奥尔萨里 - 艾玛海军 III 装配工厂 - 月形联合总部";
			parameter.itemCount = 100;
			parameter.itemCost = 120000;
			parameter.endTime = 135450023;
			item = new MarketListItemViewComponent();
			item.info = parameter;
			_containerSell.add(item);
			
			parameter = new MarketItemListParameter();
			parameter.id = 10001;
			parameter.stationName = "奥尔萨里 - 艾玛海军 III 装配工厂 - 月形联合总部";
			parameter.itemCount = 100;
			parameter.itemCost = 120000;
			parameter.endTime = 135450023;
			item = new MarketListItemViewComponent();
			item.info = parameter;
			_containerSell.add(item);
			
			parameter = new MarketItemListParameter();
			parameter.id = 10001;
			parameter.stationName = "奥尔萨里 - 艾玛海军 III 装配工厂 - 月形联合总部";
			parameter.itemCount = 100;
			parameter.itemCost = 120000;
			parameter.endTime = 135450023;
			item = new MarketListItemViewComponent();
			item.info = parameter;
			_containerSell.add(item);
			
			parameter = new MarketItemListParameter();
			parameter.id = 10001;
			parameter.stationName = "奥尔萨里 - 艾玛海军 III 装配工厂 - 月形联合总部";
			parameter.itemCount = 100;
			parameter.itemCost = 120000;
			parameter.endTime = 135450023;
			item = new MarketListItemViewComponent();
			item.info = parameter;
			_containerSell.add(item);
			
			parameter = new MarketItemListParameter();
			parameter.id = 10001;
			parameter.stationName = "奥尔萨里 - 艾玛海军 III 装配工厂 - 月形联合总部";
			parameter.itemCount = 100;
			parameter.itemCost = 120000;
			parameter.endTime = 135450023;
			item = new MarketListItemViewComponent();
			item.info = parameter;
			_containerSell.add(item);
			
			parameter = new MarketItemListParameter();
			parameter.id = 10001;
			parameter.stationName = "奥尔萨里 - 艾玛海军 III 装配工厂 - 月形联合总部";
			parameter.itemCount = 100;
			parameter.itemCost = 120000;
			parameter.endTime = 135450023;
			item = new MarketListItemViewComponent();
			item.info = parameter;
			_containerSell.add(item);
			
			parameter = new MarketItemListParameter();
			parameter.id = 10001;
			parameter.stationName = "奥尔萨里 - 艾玛海军 III 装配工厂 - 月形联合总部";
			parameter.itemCount = 100;
			parameter.itemCost = 120000;
			parameter.endTime = 135450023;
			item = new MarketListItemViewComponent();
			item.info = parameter;
			_containerSell.add(item);
			
			parameter = new MarketItemListParameter();
			parameter.id = 10001;
			parameter.stationName = "奥尔萨里 - 艾玛海军 III 装配工厂 - 月形联合总部";
			parameter.itemCount = 100;
			parameter.itemCost = 120000;
			parameter.endTime = 135450023;
			item = new MarketListItemViewComponent();
			item.info = parameter;
			_containerSell.add(item);
			
			_containerSell.layout.update();
			_scrollSell.rebuild();
		}
		
		private function onTreeNodeClick(evt: TreeEvent): void
		{
			_lblItemName.text = evt.caption;
			showInfo();
			showListComponent();
			
			evt.stopImmediatePropagation();
			evt = null;
		}
	}
}