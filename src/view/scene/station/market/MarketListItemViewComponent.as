package view.scene.station.market
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import parameters.station.MarketItemListParameter;
	
	import utils.MenuManager;
	import utils.events.MenuEvent;
	import utils.liteui.component.Label;
	import utils.liteui.component.Menu;
	import utils.liteui.component.MenuItem;
	import utils.liteui.core.Component;
	import utils.resource.ResourcePool;

	public class MarketListItemViewComponent extends Component
	{
		private var _lblStationName: Label;
		private var _lblItemCount: Label;
		private var _lblItemCost: Label;
		private var _lblEndTime: Label;
		private var _bg: MovieClip;
		private var _info: MarketItemListParameter;
		
		public function MarketListItemViewComponent()
		{
			super(ResourcePool.getResource("assets.scene1Station.market.ItemListView") as DisplayObjectContainer);
			
			_lblStationName = getUI(Label, "stationName") as Label;
			_lblItemCount = getUI(Label, "itemCount") as Label;
			_lblItemCost = getUI(Label, "itemCost") as Label;
			_lblEndTime = getUI(Label, "endTime") as Label;
			_bg = getSkin("bg") as MovieClip;
			
			sortChildIndex();
			
			_bg.alpha = 0;
			addEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		private function onMouseClick(evt: MouseEvent): void
		{
			var _menu: Menu = new Menu();
			_menu.x = evt.stageX;
			_menu.y = evt.stageY;
			
			var _item1: MenuItem = new MenuItem();
			_item1.itemName = "buy";
			_item1.text = "购买物品";
			_menu.addItem(_item1, onMenuBuy);
			
			_item1 = new MenuItem();
			_item1.itemName = "info";
			_item1.text = "查看物品信息";
			_menu.addItem(_item1, onMenuInfo);
			
			MenuManager.showMenu(_menu);
		}
		
		private function onMenuBuy(evt: MenuEvent): void
		{
			trace(evt.itemName);
		}
		
		private function onMenuInfo(evt: MenuEvent): void
		{
			trace(evt.itemName);
		}
		
		override protected function onMouseOver(evt:MouseEvent):void
		{
			_bg.alpha = .1;
		}
		
		override protected function onMouseOut(evt:MouseEvent):void
		{
			_bg.alpha = 0;
		}

		public function get info():MarketItemListParameter
		{
			return _info;
		}

		public function set info(value:MarketItemListParameter):void
		{
			if(value != null)
			{
				_info = value;
				
				_lblStationName.text = value.stationName;
				_lblItemCount.text = value.itemCount.toString();
				_lblItemCost.text = value.itemCost.toString();
				_lblEndTime.text = value.endTime.toString();
			}
		}
	}
}