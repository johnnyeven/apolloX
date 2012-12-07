package utils.liteui.component
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Shape;
	
	import utils.StringUtils;
	import utils.liteui.core.Component;
	import utils.liteui.layouts.Margin;
	import utils.resource.ResourcePool;
	
	public class TreeNode extends Component
	{
		private var _rootNode: TreeView;
		private var _parentNode: TreeNode;
		private var _caption: Label;
		private var _listIcon: DisplayObject;
		private var _seperator: DisplayObject;
		private var _clickArea: Shape;
		private var _childNode: Vector.<TreeNode>;
		public static var padding: Margin = new Margin(8, 0, 8, 0);
		public static var indent: uint = 10;
		
		public function TreeNode(_caption: String = null, _parent: TreeNode = null, _root: TreeView = null)
		{
			super();
			_childNode = new Vector.<TreeNode>();
			
			this._caption = new Label();
			this._caption.color = 0x0099FF;
			this._caption.size = 12;
			this._caption.x = indent;
			this._caption.y = padding.top;
			addChild(this._caption);
			
			if(!StringUtils.empty(_caption))
			{
				this._caption.text = _caption;
			}
			if(_parent != null)
			{
				_parentNode = _parent;
			}
			if(_root != null)
			{
				_rootNode = _root;
			}
			
			_seperator = ResourcePool.getResource("ui.TreeView.Seperator");
			_listIcon = ResourcePool.getResource("ui.TreeView.Icon");
			
			addChild(_seperator);
			addChild(_listIcon);
			
			_clickArea = new Shape();
			addChild(_clickArea);
		}
		
		override public function get height():Number
		{
			return padding.top + _caption.height + padding.bottom;
		}

		public function get rootNode():TreeView
		{
			return _rootNode;
		}

		public function set rootNode(value:TreeView):void
		{
			_rootNode = value;
		}
		
		public function get parentNode():TreeNode
		{
			return _parentNode;
		}
		
		public function set parentNode(value:TreeNode):void
		{
			_parentNode = value;
		}

		public function get caption(): String
		{
			return _caption.text;
		}

		public function set caption(value: String):void
		{
			_caption.text = value;
			autoFixListIcon();
		}
		
		public function get color(): uint
		{
			return _caption.color;
		}
		
		public function set color(value: uint):void
		{
			_caption.color = value;
		}
		
		public function get size(): uint
		{
			return _caption.size;
		}
		
		public function set size(value: uint):void
		{
			_caption.size = value;
		}
		
		public function update(): void
		{
			if(_rootNode != null)
			{
				_clickArea.graphics.clear();
				_clickArea.graphics.beginFill(0xFFFFFF, 0);
				_clickArea.graphics.drawRect(0, 0, _rootNode.innerWidth, height);
				_clickArea.graphics.endFill();
			}
			_caption.x = indent;
			_caption.y = padding.top;
			
			_seperator.x = padding.left;
			_seperator.y = height - _seperator.height;
			_seperator.width = width - padding.left - padding.right;
			
			autoFixListIcon();
		}
		
		private function autoFixListIcon(): void
		{
			_listIcon.x = 0;
			_listIcon.y = (height - _listIcon.height) * .5;
		}
	}
}