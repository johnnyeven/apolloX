package view.scene.station.market
{
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	import mediator.scene.station.MarketViewMediator;
	
	import utils.liteui.component.Button;
	import utils.liteui.component.Label;
	import utils.liteui.component.TreeNode;
	import utils.liteui.component.TreeView;
	import utils.liteui.core.Component;
	import utils.resource.ResourcePool;
	
	public class MarketViewComponent extends Component
	{
		private var _btnClose: Button;
		private var _caption: Label;
		
		public function MarketViewComponent()
		{
			super(ResourcePool.getResource("assets.scene1Station.market.view") as DisplayObjectContainer);
			
			_btnClose = getUI(Button, "btnClose") as Button;
			_caption = getUI(Label, "caption") as Label;
			
			sortChildIndex();
			_btnClose.addEventListener(MouseEvent.CLICK, onBtnCloseClick);
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
			
			var sub1: TreeNode = new TreeNode();
			sub1.caption = "youlaiyoulai";
			sub.add(sub1);
			
			var sub2: TreeNode = new TreeNode();
			sub2.caption = "youlaiyoulai123";
			sub1.add(sub2);
			
			tree.update();
		}
	}
}