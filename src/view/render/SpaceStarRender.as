package view.render
{
	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	import flash.geom.Rectangle;
	
	import utils.GameManager;
	import utils.configuration.GlobalContextConfig;
	import utils.liteui.core.Component;
	
	import view.space.background.SpaceBackgroundComponent;

	public class SpaceStarRender extends Render
	{
		private static const STAR_LEVEL: int = 5;
		private static const STAR_COUNT: int = 100;
		private var _container: Sprite;
		private var _displayBitmapData: BitmapData;
		private var _displayContainer: Vector.<Bitmap>;
		private var _deepContainer: Array;
		private var _backgroundComponent: SpaceBackgroundComponent;
		
		public function SpaceStarRender()
		{
			super();
			_displayBitmapData = new BitmapData(1, 1, false, 0xFFFFFF);
			_displayBitmapData.fillRect(new Rectangle(0, 0, 1, 1), 0xFFFFFF);
			
			_displayContainer = new Vector.<Bitmap>();
			_deepContainer = new Array();
		}
		
//		override public function rendering(force:Boolean=false):void
//		{
//			var _childContainer: Sprite;
//			var _startX: Number;
//			var _startY: Number;
//			
//			for(var i: int = 0; i<_container.numChildren; i++)
//			{
//				_container.getChildAt(i).x = -_backgroundComponent.screenStartX * (1 / (i + 1));
//				_container.getChildAt(i).y = -_backgroundComponent.screenStartY * (1 / (i + 1));
//			}
//			
//			if(_displayContainer.length < STAR_COUNT)
//			{
//				var childIndex: int = Math.floor(Math.random() * 5);
//				_childContainer = _container.getChildAt(childIndex) as Sprite;
//				
//				var _star: Bitmap;
//				_star = new Bitmap(_displayBitmapData);
//				//				var _star: Shape = new Shape();
//				//				_star.graphics.beginBitmapFill(_displayBitmapData);
//				//				_star.graphics.drawRect(0, 0, 1, 1);
//				//				_star.graphics.endFill();
//				if(Math.random() > .5)
//				{
//					_startX = _backgroundComponent.cutviewStartX;
//				}
//				else
//				{
//					_startX = _backgroundComponent.cutviewStartX + GlobalContextConfig.Width + MapContextConfig.TileSize.x;
//				}
//				if(Math.random() > .5)
//				{
//					_startY = _backgroundComponent.cutviewStartY;
//				}
//				else
//				{
//					_startY = _backgroundComponent.cutviewStartY + GlobalContextConfig.Height + MapContextConfig.TileSize.y;
//				}
//				_star.x = Math.random() * MapContextConfig.TileSize.x + _startX;
//				_star.y = Math.random() * MapContextConfig.TileSize.y + _startY;
//				_star.alpha = 1 / (childIndex + 1);
//				_childContainer.addChild(_star);
//				_displayContainer.push(_star);
//				_deepContainer.push(childIndex);
//			}
//			
//			for(i = 0; i<_displayContainer.length; i++)
//			{
//				var _percent: Number = 1 / (_deepContainer[i] + 1);
//				_startX = _backgroundComponent.cutviewStartX * _percent;
//				_startY = _backgroundComponent.cutviewStartY * _percent;
//				_childContainer = _container.getChildAt(_deepContainer[i]) as Sprite;
//				
//				if(_displayContainer[i].x > GlobalContextConfig.Width + MapContextConfig.TileSize.x * 2 + _startX ||
//					_displayContainer[i].x < _startX ||
//					_displayContainer[i].y > GlobalContextConfig.Height + MapContextConfig.TileSize.y * 2 + _startY ||
//					_displayContainer[i].y < _startY)
//				{
//					_childContainer.removeChild(_displayContainer[i]);
//					_displayContainer.splice(i, 1);
//					_deepContainer.splice(i, 1);
//				}
//				else
//				{
//					_displayContainer[i].x += (.5 * _percent);
//				}
//			}
//		}
		
		override public function rendering(force:Boolean=false):void
		{
			var _childContainer: Sprite;
			
			for(var i: int = 0; i<_container.numChildren; i++)
			{
				_container.getChildAt(i).x = -_backgroundComponent.screenStartX * (1 / (i + 1));
				_container.getChildAt(i).y = -_backgroundComponent.screenStartY * (1 / (i + 1));
			}
			
			if(_displayContainer.length < STAR_COUNT)
			{
				var childIndex: int = Math.floor(Math.random() * 5);
				_childContainer = _container.getChildAt(childIndex) as Sprite;
				
				var _star: Bitmap;
				_star = new Bitmap(_displayBitmapData);
				_star.x = Math.random() * GlobalContextConfig.Width + _backgroundComponent.screenStartX * 1 / (childIndex + 1);
				_star.y = Math.random() * GlobalContextConfig.Height + _backgroundComponent.screenStartY * 1 / (childIndex + 1);
				_star.alpha = 1 / (childIndex + 1);
				_childContainer.addChild(_star);
				TweenLite.from(_star, 2, {alpha: 0});
				_displayContainer.push(_star);
				_deepContainer.push(childIndex);
			}
			
			for(i = 0; i<_displayContainer.length; i++)
			{
				var _percent: Number = 1 / (_deepContainer[i] + 1);
				var _startX: Number = _backgroundComponent.screenStartX * _percent;
				var _startY: Number = _backgroundComponent.screenStartY * _percent;
				_childContainer = _container.getChildAt(_deepContainer[i]) as Sprite;
				
				if(_displayContainer[i].x > GlobalContextConfig.Width + _startX ||
				_displayContainer[i].x < _startX ||
				_displayContainer[i].y > GlobalContextConfig.Height + _startY ||
				_displayContainer[i].y < _startY)
				{
					_childContainer.removeChild(_displayContainer[i]);
					_displayContainer.splice(i, 1);
					_deepContainer.splice(i, 1);
				}
				else
				{
					_displayContainer[i].x += (.5 * _percent);
				}
			}
		}
		
		override public function set target(value:Component):void
		{
			super.target = value;
			if(value is SpaceBackgroundComponent)
			{
				_backgroundComponent = value as SpaceBackgroundComponent;
				_container = new Sprite();
				GameManager.instance.addBack(_container);
				
				for(var i: int = 0; i<STAR_LEVEL; i++)
				{
					_container.addChild(new Sprite());
				}
			}
			else
			{
				throw new IllegalOperationError("SpaceStarRender must use in SpaceBackgroundComponent");
			}
		}
	}
}