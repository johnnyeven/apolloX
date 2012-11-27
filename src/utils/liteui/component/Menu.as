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
		public static var _itemMargin: Margin = new Margin(3, 0, 3, 0);
		private var _currentChild: Menu;
		
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
			_padding = new Margin(20, 20, 20, 20);
		}
		
		public function addMenu(child: Menu): void
		{
			if(_currentChild != null)
			{
				removeMenu(_currentChild);
			}
			addChild(child);
			_currentChild = child;
		}
		
		public function removeMenu(child: Menu): void
		{
			_currentChild = null;
			removeChild(child);
		}
		
		public function addItem(_item: MenuItem, _onClick: Function = null): void
		{
			_itemList[_item.itemName] = _item;
			_callbackList[_item.itemName] = _onClick;
			_item.parentMenu = this;
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
		
		public function update(): void
		{
			var _lastItem: MenuItem;
			var _item: MenuItem;
			var _width: Number = 0;
			var _height: Number = 0;
			var _left: Number;
			var _right: Number;
			var _top: Number;
			var _bottom: Number;
			
			for each(_item in _itemList)
			{
				if(_item.margin.isZero())
				{
					_left = _itemMargin.left;
					_right = _itemMargin.right;
					_top = _itemMargin.top;
					_bottom = _itemMargin.bottom;
				}
				else
				{
					_left = _item.margin.left;
					_right = _item.margin.right;
					_top = _item.margin.top;
					_bottom = _item.margin.bottom;
				}
				
				_item.x = _padding.left + _left;
				if(_lastItem != null)
				{
					_item.y = _lastItem.y + _lastItem.height + _top + _bottom;
				}
				else
				{
					_item.y = _padding.top + _top;
				}
				_lastItem = _item;
				_width = Math.max(_width, _lastItem.width + _left + _right);
				_height += _item.height + _top + _bottom;
			}
			_width += _padding.right + _padding.left;
			_height += _padding.bottom + _padding.top;
			
			_bg.width = _width;
			_bg.height = _height;
		}
		
		override public function dispose():void
		{
			var _item: MenuItem;
			for each(_item in _itemList)
			{
				if(_item.childMenu != null)
				{
					_item.childMenu.dispose();
				}
				_item.dispose();
			}
			super.dispose();
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