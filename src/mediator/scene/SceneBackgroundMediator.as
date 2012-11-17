package mediator.scene
{
	import view.scene.SceneBackgroundComponent;
	
	import mediator.BaseMediator;
	
	public class SceneBackgroundMediator extends BaseMediator
	{
		public static const NAME: String = "Scene1BackgroundMediator";
		
		public function SceneBackgroundMediator()
		{
			super(NAME, new SceneBackgroundComponent());
		}
		
		private function get component(): SceneBackgroundComponent
		{
			return viewComponent as SceneBackgroundComponent;
		}
	}
}