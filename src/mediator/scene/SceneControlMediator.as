package mediator.scene
{
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
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