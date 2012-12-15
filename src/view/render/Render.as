package view.render
{
	import view.space.StaticComponent;

	public class Render implements IRender
	{
		protected var _target: StaticComponent;
		
		public function Render()
		{
		}
		
		public function rendering(force: Boolean = false): void
		{
			
		}
		
		protected function draw(_direction: int): void
		{
			_target.graphic.gotoAndStop(_direction);
		}

		public function get target():StaticComponent
		{
			return _target;
		}

		public function set target(value: StaticComponent):void
		{
			_target = value;
		}

	}
}