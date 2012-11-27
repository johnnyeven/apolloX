package utils.liteui.component
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import mx.utils.UIDUtil;
	
	import utils.MenuManager;
	import utils.UIUtils;
	import utils.liteui.core.Component;
	import utils.liteui.layouts.Margin;
	import utils.resource.ResourcePool;
	
	public class MenuItem extends Component
	{
		public var itemName: String;
		public var parentMenu: Menu;
		private var _margin: Margin;
		private var _padding: Margin;
		private var _bg: MovieClip;
		private var _childMenuIcon: MovieClip;
		private var _text: Label;
		private var _childMenu: Menu;
		private var _onChildMouseOver: Boolean = false;
		public static const ICON_OFFSET: int = 10;
		
		public function MenuItem(_skin:DisplayObjectContainer=null)
		{
			if(_skin == null)
			{
				_skin = ResourcePool.getResource("ui.menu.itemBG") as DisplayObjectContainer;
			}
			super(_skin);
			
			_bg = getSkin("bg") as MovieClip;
			_childMenuIcon = getSkin("childMenuIcon") as MovieClip;
			if(_childMenuIcon != null)
			{
				_childMenuIcon.visible = false;
			}
			
			_text = new Label();
			addChild(_text);
			_text.color = 0xFFFFFF;
			_text.autoSize = true;
			
			_margin = new Margin(0, 0, 0, 0);
			_padding = new Margin(0, 0, 0, 0);
		}
		
		public function set text(value: String): void
		{
			_text.text = value;
		}
		
		public function set color(value: uint): void
		{
			_text.color = value;
		}
		
		public function set indent(value: Number): void
		{
			_text.x = value + _padding.left;
		}

		public function get margin(): Margin
		{
			return _margin;
		}

		public function set margin(value: Margin):void
		{
			_margin = value;
		}

		public function get padding(): Margin
		{
			return _padding;
		}

		public function set padding(value: Margin):void
		{
			_padding = value;
		}
		
		override public function get width():Number
		{
			var _width:Number;
			if(_bg != null)
			{
				_width = Math.max(_text.width, UIUtils.getSkinSize(_bg).x);
			}
			else
			{
				_width = _text.width;
			}
			if(_childMenu != null)
			{
				_width += _childMenuIcon.width + ICON_OFFSET;
			}
			return _width + _padding.left + _padding.right;
		}
		
		override public function get height():Number
		{
			var _height: Number;
			if(_bg != null)
			{
				_height = Math.max(_text.height, UIUtils.getSkinSize(_bg).y);
			}
			else
			{
				_height = _text.height;
			}
			return _height + _padding.top + _padding.bottom;
		}

		public function get childMenu():Menu
		{
			return _childMenu;
		}

		public function set childMenu(value:Menu):void
		{
			_childMenu = value;
			_childMenuIcon.x = parentMenu.width - parentMenu.padding.left - parentMenu.padding.right + ICON_OFFSET;
			_childMenuIcon.y = (height - _childMenuIcon.height) * .5;
			_childMenuIcon.visible = true;
			
			_childMenu.x = width;
			_childMenu.y = y - 5;
			_childMenu.addEventListener(MouseEvent.MOUSE_OVER, onChildOver);
			_childMenu.addEventListener(MouseEvent.MOUSE_OUT, onChildOut);
			
			parentMenu.update();
		}
		
		protected function onChildOver(evt: MouseEvent): void
		{
			_onChildMouseOver = true;
		}
		
		protected function onChildOut(evt: MouseEvent): void
		{
			_onChildMouseOver = false;
		}
		
		override protected function onMouseOver(evt:MouseEvent):void
		{
			if(_childMenu != null)
			{
				parentMenu.addMenu(_childMenu);
			}
		}
		
		override protected function onMouseOut(evt:MouseEvent):void
		{
			if(!_onChildMouseOver)
			{
				if(_childMenu != null)
				{
					parentMenu.removeMenu(_childMenu);
				}
			}
		}
	}
}