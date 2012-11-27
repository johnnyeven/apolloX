package utils.liteui.component
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	
	import mx.utils.UIDUtil;
	
	import utils.UIUtils;
	import utils.liteui.core.Component;
	import utils.liteui.layouts.Margin;
	import utils.resource.ResourcePool;
	
	public class MenuItem extends Component
	{
		public var itemName: String;
		private var _margin: Margin;
		private var _padding: Margin;
		private var _bg: MovieClip;
		private var _text: Label;
		
		public function MenuItem(_skin:DisplayObjectContainer=null)
		{
			if(_skin == null)
			{
				_skin = ResourcePool.getResource("ui.menu.itemBG") as DisplayObjectContainer;
			}
			super(_skin);
			
			_bg = getSkin("bg") as MovieClip;
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
			return _width + _padding.left + _padding.right;
		}
		
		override public function get height():Number
		{
			var _height: Number;
			if(_bg != null)
			{
				_height = Math.max(_text.textHeight, UIUtils.getSkinSize(_bg).y);
			}
			else
			{
				_height = _text.textHeight;
			}
			return _height + _padding.top + _padding.bottom;
		}
	}
}