package mediator.scene
{
	import view.scene.Scene1BackgroundComponent;
	
	import mediator.BaseMediator;
	
	public class Scene1BackgroundMediator extends BaseMediator
	{
		public static const NAME: String = "Scene1BackgroundMediator";
		
		public function Scene1BackgroundMediator(viewComponent:Object=null)
		{
			super(NAME, new Scene1BackgroundComponent());
		}
		
		private function get component(): Scene1BackgroundComponent
		{
			return viewComponent as Scene1BackgroundComponent;
		}
	}
}