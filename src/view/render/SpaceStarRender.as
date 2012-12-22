package view.render
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	import flash.geom.Rectangle;
	
	import utils.GameManager;
	import utils.configuration.GlobalContextConfig;
	import utils.liteui.core.Component;
	
	import view.space.background.SpaceBackgroundComponent;

	public class SpaceStarRender extends Render
	{
		private static const STAR_LEVEL: int = 2;
		private static const STAR_COUNT: int = 100;
		private var _container: Sprite;
		private var _displayBitmapData: BitmapData;
		private var _displayContainer: Vector.<Bitmap>;
		
		public function SpaceStarRender()
		{
			super();
			_displayBitmapData = new BitmapData(1, 1, false, 0xFFFFFF);
			_displayBitmapData.fillRect(new Rectangle(0, 0, 1, 1), 0xFFFFFF);
			
			_displayContainer = new Vector.<Bitmap>();
		}
		
		override public function rendering(force:Boolean=false):void
		{
			for(var i: int = 0; i<_displayContainer.length; i++)
			{
				if(_displayContainer[i].x > GlobalContextConfig.Width)
				{
					_container.removeChild(_displayContainer[i]);
					_displayContainer.splice(i, 1);
				}
				else
				{
					_displayContainer[i].x++;
				}
			}
		}
		
		override public function set target(value:Component):void
		{
			if(value is SpaceBackgroundComponent)
			{
				_container = new Sprite();
				GameManager.instance.addBack(_container);
				
				var _star: Bitmap;
				for(var i: int = 0; i<STAR_COUNT; i++)
				{
					_star = new Bitmap(_displayBitmapData);
					_star.x = Math.random() * GlobalContextConfig.Width;
					_star.y = Math.random() * GlobalContextConfig.Height;
					_container.addChild(_star);
					_displayContainer.push(_star);
				}
			}
			else
			{
				throw new IllegalOperationError("SpaceStarRender must use in SpaceBackgroundComponent");
			}
		}
	}
}