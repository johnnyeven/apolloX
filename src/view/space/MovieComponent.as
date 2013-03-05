package view.space
{
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;
	
	import utils.configuration.GlobalContextConfig;
	
	public class MovieComponent extends MovableComponent
	{
		protected var _currentFrame: uint;
		protected var _prevFrame: uint;
		protected var _totalFrame: uint;
		protected var _isLoopPlay: Boolean;
		protected var _isPlayEnd: Boolean;
		protected var _lastFrameTime: uint;
		protected var _playTime: uint;
		protected var _needChangeFrame: Boolean;
		
		public function MovieComponent(_skin:DisplayObjectContainer=null)
		{
			_lastFrameTime = GlobalContextConfig.Timer;
			
			_currentFrame = 0;
			_prevFrame = 0;
			_totalFrame = 0;
			_needChangeFrame = false;
			_isLoopPlay = false;
			_isPlayEnd = false;
			
			super(_skin);
		}

		public function get currentFrame():uint
		{
			return _currentFrame;
		}

		public function set currentFrame(value:uint):void
		{
			_currentFrame = value;
		}

		public function get prevFrame():uint
		{
			return _prevFrame;
		}

		public function set loopPlay(value: Boolean): void
		{
			_isLoopPlay = value;
			_isPlayEnd = false;
		}
		
		public function get isPlayEnd(): Boolean
		{
			return !_isLoopPlay && _isPlayEnd;
		}
		
		override public function get renderRect(): Rectangle
		{
			return _renderRect;
		}
		
		override public function update():void
		{
			enterFrame();
			super.update();
		}
		
		protected function enterFrame(): Boolean
		{
			
		}

		public function get needChangeFrame():Boolean
		{
			return _needChangeFrame;
		}

		public function set needChangeFrame(value:Boolean):void
		{
			_needChangeFrame = value;
		}
	}
}