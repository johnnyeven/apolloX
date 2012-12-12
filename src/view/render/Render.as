package view.render
{
	import view.space.SpaceComponent;

	public class Render
	{
		protected var _target: SpaceComponent;
		
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

		public function get target():SpaceComponent
		{
			return _target;
		}

		public function set target(value:SpaceComponent):void
		{
			_target = value;
		}

	}
}