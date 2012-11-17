package mediator.scene
{
	import mediator.BaseMediator;
	
	import view.scene.SceneControlComponent;
	
	public class SceneControlMediator extends BaseMediator
	{
		public static const NAME: String = "SceneControlMediator";
		
		public function SceneControlMediator(viewComponent:Object=null)
		{
			super(NAME, new SceneControlComponent());
		}
		
		private function get component(): SceneControlComponent
		{
			return viewComponent as SceneControlComponent;
		}
	}
}