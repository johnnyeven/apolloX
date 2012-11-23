package utils.liteui.component
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Shape;
	
	import utils.enum.ProgressBarType;
	import utils.liteui.core.Component;
	
	public class ProgressBar extends Component
	{
		public var type: int = ProgressBarType.MASK;
		protected var _mask: Shape;
		protected var _trackObject: DisplayObject;
		protected var _barObject: DisplayObject;
		protected var _barWidth: Number = 0;
		private var _percent: Number = 0;
		
		public function ProgressBar(_skin:DisplayObjectContainer=null, _type: int = ProgressBarType.MASK)
		{
			super(_skin);
			_trackObject = getSkin("track");
			_barObject = getSkin("bar");
			
			type = _type;
		}
		
		public function initProgressBar(): void
		{
			if(type == ProgressBarType.MASK)
			{
				_mask = new Shape();
				_mask.graphics.beginFill(0, 1);
				_mask.graphics.drawRect(0, 0, 0, 1);
				_mask.graphics.endFill();
				addChild(_mask);
				_barObject.mask = _mask;
				_mask.x = _barObject.x;
				_mask.y = _barObject.y;
				_mask.height = _barObject.height;
			}
			else if(type == ProgressBarType.SCALE)
			{
				_barWidth = _barObject.width;
				_barObject.width = 0;
			}
			else
			{
				if(_barObject is MovieClip)
				{
					(_barObject as MovieClip).gotoAndStop(1);
				}
			}
			update();
		}
		
		public function get percent():Number
		{
			return _percent;
		}

		public function set percent(value:Number):void
		{
			_percent = value;
			update();
		}
		
		private function update(): void
		{
			if(_percent > 1)
			{
				_percent = 1;
			}
			else if(_percent < 0 || isNaN(_percent))
			{
				_percent = 0;
			}
			if(type == ProgressBarType.MASK)
			{
				_mask.width = _percent * _barObject.width;
			}
			else if(type == ProgressBarType.SCALE)
			{
				_barObject.width = _percent * _barWidth;
			}
			else
			{
				if(_barObject is MovieClip)
				{
					(_barObject as MovieClip).gotoAndStop(Math.floor(_percent * 100));
				}
			}
		}
	}
}