package view.render
{
	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	
	import utils.GameManager;
	import utils.liteui.core.Component;
	
	import view.space.background.SpaceBackgroundComponent;

	public class SpaceStarRender extends Render
	{
		private var _container: Sprite;
		
		public function SpaceStarRender()
		{
			super();
		}
		
		override public function rendering(force:Boolean=false):void
		{
			
		}
		
		override public function set target(value:Component):void
		{
			if(value is SpaceBackgroundComponent)
			{
				_container = new Sprite();
				GameManager.instance.addBack(_container);
			}
			else
			{
				throw new IllegalOperationError("SpaceStarRender must use in SpaceBackgroundComponent");
			}
		}
	}
}