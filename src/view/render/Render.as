package view.render
{
	import com.greensock.TweenLite;
	
	import utils.liteui.core.Component;
	
	import view.space.StaticComponent;

	public class Render implements IRender
	{
		protected var _target: Component;
		
		public function Render()
		{
		}
		
		public function rendering(force: Boolean = false): void
		{
			
		}
		
		protected function draw(_direction: int): void
		{
			if(_target is StaticComponent)
			{
				(_target as StaticComponent).graphic.gotoAndStop(_direction);
			}
		}

		public function get target():Component
		{
			return _target;
		}

		public function set target(value: Component):void
		{
			_target = value;
		}

	}
}