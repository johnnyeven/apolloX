package view.space
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	
	import utils.liteui.core.Component;
	
	import view.control.BaseController;
	import view.render.Render;
	
	public class StaticComponent extends Component
	{
		public var focused: Boolean = false;
		public var inUse: Boolean = true;
		public var canBeAttack: Boolean = false;
		public var staticUpdate: Boolean = false;
		protected var _graphic: MovieClip;
		protected var _posX: Number;
		protected var _posY: Number;
		protected var _zIndex: uint = 0;
		protected var _zIndexOffset: uint = 0;
		protected var _render: Render;
		
		public function StaticComponent(_skin:DisplayObjectContainer=null)
		{
			super(_skin);
		}
		
		public function get posX():Number
		{
			return _posX;
		}
		
		public function get posY():Number
		{
			return _posY;
		}
		
		public function setPos(_x: Number, _y: Number): void
		{
			_posX = _x;
			_posY = _y;
			_zIndex = y;
		}
		
		public function get graphic():MovieClip
		{
			return _graphic;
		}
		
		public function set graphic(value:MovieClip):void
		{
			_graphic = value;
		}
		
		public function get render():Render
		{
			return _render;
		}
		
		public function set render(value:Render):void
		{
			_render = value;
			_render.target = this;
		}
		
		public function get zIndex():uint
		{
			return _zIndex + _zIndexOffset;
		}
		
		public function get zIndexOffset():uint
		{
			return _zIndexOffset;
		}
		
		public function set zIndexOffset(value:uint):void
		{
			_zIndexOffset = value;
		}
	}
}