package view.space.background
{
	import configuration.GlobalContextConfig;
	import configuration.MapContextConfig;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import utils.algorithms.SilzAstar;
	import utils.events.LoaderEvent;
	import utils.events.MapEvent;
	import utils.events.MapIOErrorEvent;
	import utils.language.LanguageManager;
	import utils.liteui.core.Component;
	import utils.loader.ResourceLoadManager;
	import utils.loader.XMLLoader;
	import utils.resource.ResourcePool;
	
	public class SpaceBackgroundComponent extends Component
	{
		private var _id: String = "default";
		private var _xmlLoader: XMLLoader;
		private static var _astar: SilzAstar;
		private var _buffer: BitmapData;
		private var _displayBuffer: Shape;
		private var _bufferContainer: Vector.<BitmapData>;
		private var _displayBufferContainer: Vector.<Shape>;
		private var _displayBufferDeep: Array;
		private var _displayBufferPoint: Array;
		private var _preCenter: Point;
		private var _preStart: Point;
		private var _centerX: Number;
		private var _centerY: Number;
		private var _negativePath: Array;
		private var _mapReady: Boolean;
		private var _cameraView: Rectangle;
		private var _cameraCutView: Rectangle;
		protected var _mapXML: XML;
		public var startX: int;
		public var startY: int;
		
		public function SpaceBackgroundComponent()
		{
			super();
			
			_preCenter = new Point();
			_preStart = new Point(-1, -1);
			_negativePath = new Array();
			_displayBufferDeep = new Array();
			_displayBufferPoint = new Array();
			_mapReady = false;
			_cameraView = new Rectangle();
			_cameraCutView = new Rectangle();
		}
		
		public function load(): void
		{
			if(_xmlLoader == null)
			{
				_xmlLoader = new XMLLoader("resources/background/xml/" + id + ".xml");
				_xmlLoader.addEventListener(LoaderEvent.COMPLETE, onXMLLoadComplete);
				_xmlLoader.addEventListener(LoaderEvent.PROGRESS, onXMLLoadProgress);
				_xmlLoader.addEventListener(LoaderEvent.IO_ERROR, onXMLLoadIOError);
				//_xmlLoader.version = VersionUtils.getVersion("resource_config");
				
				ApplicationFacade.getInstance().sendNotification(ResourceLoadManager.SET_PROGRESSBAR_TITLE_NOTE, LanguageManager.getInstance().lang("load_map_config"));
				ApplicationFacade.getInstance().sendNotification(ResourceLoadManager.SHOW_PROGRESSBAR_NOTE);
				
				_xmlLoader.load();
			}
		}
		
		protected function onXMLLoadComplete(evt: LoaderEvent): void
		{
			ApplicationFacade.getInstance().sendNotification(ResourceLoadManager.HIDE_PROGRESSBAR_NOTE);
			removeXMLLoaderListener();
			
			_mapXML = _xmlLoader.configXML;
			
			if(_mapXML.mapId != _id)
			{
				dispatchEvent(new MapIOErrorEvent(MapIOErrorEvent.VERIFY_ERROR));
			}
			else
			{
				MapContextConfig.MapSize.x = parseInt(_mapXML.width);
				MapContextConfig.MapSize.y = parseInt(_mapXML.height);
				
				centerX = startX;
				centerY = startY;
				
				loadMap();
			}
		}
		
		protected function onXMLLoadProgress(evt: LoaderEvent): void
		{
			var _percent: int = Math.floor(evt.bytesLoaded / evt.bytesTotal);
			ApplicationFacade.getInstance().sendNotification(ResourceLoadManager.SET_PROGRESSBAR_PERCENT_NOTE, _percent);
		}
		
		protected function onXMLLoadIOError(evt: LoaderEvent): void
		{
			removeXMLLoaderListener();
			ApplicationFacade.getInstance().sendNotification(ResourceLoadManager.HIDE_PROGRESSBAR_NOTE);
		}
		
		private function removeXMLLoaderListener(): void
		{
			_xmlLoader.removeEventListener(LoaderEvent.COMPLETE, onXMLLoadComplete);
			_xmlLoader.removeEventListener(LoaderEvent.PROGRESS, onXMLLoadProgress);
			_xmlLoader.removeEventListener(LoaderEvent.IO_ERROR, onXMLLoadIOError);
		}
		
		public function loadMap(): void
		{
			ResourceLoadManager.load(_id + "_necessary_background", true, "", onMapLoaded);
		}
		
		private function onMapLoaded(evt: LoaderEvent): void
		{
			_bufferContainer = new Vector.<BitmapData>();
			
			var _resource: XML;
			var _bufferData: BitmapData;
			for each(_resource in _mapXML.resources.children())
			{
				_bufferData = (ResourcePool.getResource(_resource.@className) as Bitmap).bitmapData;
				_bufferContainer.push(_bufferData);
				_displayBufferDeep.push(parseInt(_resource.@index));
				_displayBufferPoint.push(new Point(parseInt(_resource.@x), parseInt(_resource.@y)));
			}
			_mapReady = true;
			
			init();
		}
		
		public function init(): void
		{
			initDisplayBuffer();
			
			dispatchEvent(new MapEvent(MapEvent.MAP_READY));
		}
		
		public function initDisplayBuffer(): void
		{
			_displayBufferContainer = new Vector.<Shape>();
			var _displayBufferShape: Shape;
			for(var i: int = 0; i<_bufferContainer.length; i++)
			{
				_displayBufferShape = new Shape();
				_displayBufferContainer.push(_displayBufferShape);
				addChild(_displayBufferShape);
				
				var _shapePoint: Point = _displayBufferPoint[i] as Point;
				_displayBufferShape.x = _shapePoint.x;
				_displayBufferShape.y = _shapePoint.y;
				
				_displayBufferShape.graphics.beginBitmapFill(_bufferContainer[i]);
				_displayBufferShape.graphics.drawRect(0, 0, _bufferContainer[i].width, _bufferContainer[i].height);
			}
		}
		
		public function render(enforceRender: Boolean = false): void
		{
			if(_centerX == _preCenter.x && _centerY == _preCenter.y)
			{
				return;
			}
			else
			{
				for(var i: int = 0; i<_displayBufferContainer.length; i++)
				{
					_displayBufferContainer[i].x = -screenStartX * _displayBufferDeep[i];
					_displayBufferContainer[i].y = -screenStartY * _displayBufferDeep[i];
				}
				
				_preCenter.x = _centerX;
				_preCenter.y = _centerY;
			}
		}

		public function get id():String
		{
			return _id;
		}

		public function set id(value:String):void
		{
			_id = value;
			load();
		}
		
		public function get centerX():Number
		{
			return _centerX;
		}
		
		public function set centerX(value:Number):void
		{
			value = Math.max(value, GlobalContextConfig.Width * .5);
			value = Math.min(value, MapContextConfig.MapSize.x - GlobalContextConfig.Width * .5);
			_centerX = value;
		}
		
		public function get centerY():Number
		{
			return _centerY;
		}
		
		public function set centerY(value:Number):void
		{
			value = Math.max(value, GlobalContextConfig.Height * .5);
			value = Math.min(value, MapContextConfig.MapSize.y - GlobalContextConfig.Height * .5);
			_centerY = value;
		}
		
		protected function get screenStartX(): Number
		{
			var _screenStartX: Number = centerX - int(GlobalContextConfig.Width * .5);
			_screenStartX = Math.max(0, _screenStartX);
			_screenStartX = Math.min(MapContextConfig.MapSize.x - GlobalContextConfig.Width, _screenStartX);
			
			return _screenStartX;
		}
		
		protected function get screenStartY(): Number
		{
			var _screenStartY: Number = centerY - int(GlobalContextConfig.Height * .5);
			_screenStartY = Math.max(0, _screenStartY);
			_screenStartY = Math.min(MapContextConfig.MapSize.y - GlobalContextConfig.Height, _screenStartY);
			
			return _screenStartY;
		}
		
		protected function get cutviewStartX(): Number
		{
			var _cutviewStartX: Number = screenStartX - MapContextConfig.TileSize.x;
			_cutviewStartX = Math.max(0, _cutviewStartX);
			return _cutviewStartX;
		}
		
		protected function get cutviewStartY(): Number
		{
			var _cutviewStartY: Number = screenStartY - MapContextConfig.TileSize.y;
			_cutviewStartY = Math.max(0, _cutviewStartY);
			return _cutviewStartY;
		}

		public function get displayBuffer():Shape
		{
			return _displayBuffer;
		}
	}
}