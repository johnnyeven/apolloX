package view.scene.station.market
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import mediator.scene.station.MarketViewMediator;
	
	import utils.liteui.component.Button;
	import utils.liteui.component.CaptionButton;
	import utils.liteui.component.Label;
	import utils.liteui.component.TreeNode;
	import utils.liteui.component.TreeView;
	import utils.liteui.core.Component;
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
		
		public function MarketViewComponent()
		{
			super(ResourcePool.getResource("assets.scene1Station.market.view") as DisplayObjectContainer);
			
			_btnClose = getUI(Button, "btnClose") as Button;
			_caption = getUI(Label, "caption") as Label;
			_btnQuery = getUI(CaptionButton, "btnQuery") as CaptionButton;
			_lblStandby1 = getUI(Label, "lblStandby1") as Label;
			_lblStandby2 = getUI(Label, "lblStandby2") as Label;
			_btnBuy = getUI(CaptionButton, "btnBuy") as CaptionButton;
			
			sortChildIndex();
			
			_btnClose.addEventListener(MouseEvent.CLICK, onBtnCloseClick);
			_btnBuy.visible = false;
			
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
	}
}