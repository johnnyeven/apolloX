package utils.liteui.component
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	
	import utils.liteui.core.Component;
	
	public class TreeView extends Component
	{
		private var _container: Container;
		private var _scrollBar: ScrollBar;
		
		public function TreeView()
		{
			super();
		}
		
		override public function set width(value:Number):void
		{
			_container.contentWidth = value;
			_container.layout.update();
		}
		
		override public function set height(value:Number):void
		{
			_scrollBar.height = value;
			_container.contentHeight = value;
			_container.layout.update();
			_scrollBar.rebuild();
		}
		
		override public function get width():Number
		{
			return _container.contentWidth;
		}
		
		override public function get height():Number
		{
			return _container.contentHeight;
		}
	}
}