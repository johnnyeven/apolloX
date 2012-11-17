package utils.liteui.component
{
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	public class ToggleButton extends CaptionButton
	{
		protected var _toggleStatus: Boolean;
		
		public function ToggleButton(_skin:DisplayObjectContainer=null)
		{
			super(_skin);
			_toggleStatus = false;
			addEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		protected function onMouseClick(evt: MouseEvent): void
		{
			if(_toggleStatus)
			{
				_toggleStatus = false;
				setMouseNormalSkin();
			}
			else
			{
				_toggleStatus = true;
				setMouseDownSkin();
			}
		}
		
		public function set toggle(value: Boolean): void
		{
			if(value != _toggleStatus)
			{
				_toggleStatus = value;
				if(_toggleStatus)
				{
					setMouseDownSkin();
				}
				else
				{
					setMouseNormalSkin();
				}
			}
		}
		
		public function get toggle(): Boolean
		{
			return _toggleStatus;
		}
	}
}