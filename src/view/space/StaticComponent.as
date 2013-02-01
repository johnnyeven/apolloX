package view.space
{
	import com.greensock.TweenLite;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	
	import utils.liteui.core.Component;
	
	import view.control.BaseController;
	import view.render.IRender;
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
		protected var _additionalRender: Vector.<IRender>;
		
		public function StaticComponent(_skin:DisplayObjectContainer=null)
		{
			super(_skin);
		}
		
		protected function loadResource(): void
		{
			//Interface: Load graphic
		}
		
		public function update(): void
		{
			if(_graphic != null && inUse)
			{
				_render.rendering();
			}
			if(_additionalRender != null)
			{
				for(var i: int = 0; i<_additionalRender.length; i++)
				{
					_additionalRender[i].rendering();
				}
			}
		}
		
		public function addRender(value: IRender): void
		{
			if(_additionalRender == null)
			{
				_additionalRender = new Vector.<IRender>();
			}
			_additionalRender.push(value);
			value.target = this;
		}
		
		public function removeRender(value: IRender): void
		{
			if(_additionalRender != null)
			{
				var i: int = _additionalRender.indexOf(value);
				if(i != -1)
				{
					_additionalRender[i].target = null;
					_additionalRender.splice(i, 1);
				}
			}
		}
		
		public function removeRenders(): void
		{
			if(_additionalRender != null)
			{
				_additionalRender.splice(0, _additionalRender.length);
			}
		}
		
		public function isMovingOut(callback: Function = null): void
		{
			TweenLite.to(this, .5, {alpha: 0, onComplete: callback});
		}
		
		public function isMovingIn(callback: Function = null): void
		{
			TweenLite.to(this, .5, {alpha: 1, onComplete: callback});
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
			_zIndex = _y;
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
			return _posY + _zIndexOffset;
		}
		
		public function get zIndexOffset():uint
		{
			return _zIndexOffset;
		}
		
		public function set zIndexOffset(value:uint):void
		{
			_zIndexOffset = value;
		}
		
		override public function dispose():void
		{
			inUse = false;
			focused = false;
			canBeAttack = false;
			_graphic.graphics.clear();
			_graphic = null;
			_render = null;
			_additionalRender.splice(0, _additionalRender.length);
			
			super.dispose();
		}
	}
}