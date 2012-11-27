package utils.liteui.component
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.utils.Dictionary;
	
	import utils.liteui.core.Component;
	import utils.liteui.layouts.Margin;
	import utils.resource.ResourcePool;
	
	public class Menu extends Component
	{
		private var _bg: MovieClip;
		private var _itemList: Dictionary;
		private var _callbackList: Dictionary;
		private var _padding: Margin;
		private var _itemMargin: Margin;
		
		public function Menu(_skin:DisplayObjectContainer=null)
		{
			if(_skin == null)
			{
				_skin = ResourcePool.getResource("ui.menu.BG") as DisplayObjectContainer;
			}
			super(_skin);
			
			_bg = getSkin("bg") as MovieClip;
			_itemList = new Dictionary();
			_callbackList = new Dictionary();
			_padding = new Margin(0, 0, 0, 0);
		}
		
		public function addItem(_item: MenuItem, _onClick: Function = null): void
		{
			_itemList[_item.itemName] = _item;
			_callbackList[_item.itemName] = _onClick;
			addChild(_item);
			update();
		}
		
		public function removeItem(_item: MenuItem): void
		{
			delete _itemList[_item.itemName];
			delete _callbackList[_item.itemName];
			removeChild(_item);
			_item.dispose();
			update();
		}
		
		public function removeItemByName(_itemName: String): void
		{
			var _item: MenuItem = _itemList[_itemName] as MenuItem
			delete _itemList[_itemName];
			delete _callbackList[_itemName];
			if(_item != null)
			{
				removeChild(_item);
				_item.dispose();
			}
			update();
		}
		
		protected function update(): void
		{
			var _lastItem: MenuItem;
			var _item: MenuItem;
			var _width: Number = 0;
			var _height: Number = 0;
			for each(_item in _itemList)
			{
				_item.x = _padding.left + _item.margin.left;
				if(_lastItem != null)
				{
					_item.y = _lastItem.y + _lastItem.height + _lastItem.margin.top + _lastItem.margin.bottom;
				}
				else
				{
					_item.y = _padding.top + _item.margin.top;
				}
				_lastItem = _item;
				_width = Math.max(_width, _lastItem.width + _lastItem.margin.left + _lastItem.margin.right);
				_height += _item.height + _item.margin.top + _item.margin.bottom;
			}
			_width += _padding.right + _padding.left;
			_height += _padding.bottom + _padding.top;
			
			_bg.width = _width;
			_bg.height = _height;
		}
		
		override public function set width(value:Number):void
		{
			
		}
		
		override public function set height(value:Number):void
		{
			
		}

		public function get padding():Margin
		{
			return _padding;
		}

		public function set padding(value:Margin):void
		{
			_padding = value;
			update();
		}
	}
}