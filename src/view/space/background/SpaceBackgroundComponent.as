package view.space.background
{
	import enum.EnumAction;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.System;
	import flash.utils.getTimer;
	
	import utils.algorithms.SilzAstar;
	import utils.configuration.GlobalContextConfig;
	import utils.configuration.MapContextConfig;
	import utils.events.LoaderEvent;
	import utils.events.MapEvent;
	import utils.events.MapIOErrorEvent;
	import utils.language.LanguageManager;
	import utils.liteui.core.Component;
	import utils.loader.ResourceLoadManager;
	import utils.loader.XMLLoader;
	import utils.resource.ResourcePool;
	
	import view.space.MovableComponent;
	import view.render.IRender;
	
	public class SpaceBackgroundComponent extends Component
	{
		private var _id: String = "default";
		private var _xmlLoader: XMLLoader;
		private static var _astar: SilzAstar;
		private var _alphaMap: BitmapData;
		private var _bufferContainer: Vector.<DisplayObject>;
		private var _displayBufferContainer: Vector.<DisplayObject>;
		private var _displayBufferDeep: Array;
		private var _displayBufferPoint: Array;
		private var _preCenter: Point;
		private var _centerX: Number;
		private var _centerY: Number;
		private var _negativePath: Array;
		private var _mapReady: Boolean;
		private var _cameraView: Rectangle;
		private var _cameraCutView: Rectangle;
		private var _mainLayer: Number = 1;
		protected var _mapXML: XML;
		public var startX: int;
		public var startY: int;
		private var _focus: MovableComponent;
		private var _enableAstar: Boolean;
		protected var _additionalRender: Vector.<IRender>;
		
		public function SpaceBackgroundComponent()
		{
			super();
			
			_preCenter = new Point();
			_displayBufferDeep = new Array();
			_displayBufferPoint = new Array();
			_mapReady = false;
			_cameraView = new Rectangle();
			_cameraCutView = new Rectangle();
			_enableAstar = false;
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
				MapContextConfig.MapSize.x = parseFloat(_mapXML.width);
				MapContextConfig.MapSize.y = parseFloat(_mapXML.height);
				MapContextConfig.BlockSize.x = parseFloat(_mapXML.blockWidth);
				MapContextConfig.BlockSize.y = parseFloat(_mapXML.blockHeight);
				MapContextConfig.TileSize.x = parseFloat(_mapXML.tileWidth);
				MapContextConfig.TileSize.y = parseFloat(_mapXML.tileHeight);
				_enableAstar = (_mapXML.enableAstar == "true");
				
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
			_bufferContainer = new Vector.<DisplayObject>();
			
			var _resource: XML;
			for each(_resource in _mapXML.resources.children())
			{
				switch(_resource.localName())
				{
					case "background":
						_bufferContainer.push(ResourcePool.getResource(_resource.@className));
						_displayBufferDeep.push(parseFloat(_resource.@deep));
						_displayBufferPoint.push(new Point(parseInt(_resource.@x), parseInt(_resource.@y)));
						break;
					case "mainLayer":
						_mainLayer = parseFloat(_resource.@deep);
						break;
					case "roadmap":
						if(_enableAstar)
						{
							resetRoadPath();
							var _roadMap: BitmapData = (ResourcePool.getResource(_resource.@className) as Bitmap).bitmapData;
							
							var percentage: Number = _roadMap.width / MapContextConfig.MapSize.x;
							var width: uint = int(MapContextConfig.MapSize.x / MapContextConfig.BlockSize.x);
							var height: uint = int(MapContextConfig.MapSize.y / MapContextConfig.BlockSize.y);
							
							for (var y: uint = 0; y < height; y++)
							{
								for (var x: uint = 0; x < width; x++)
								{
									_negativePath[y][x] = _roadMap.getPixel32(int(MapContextConfig.BlockSize.x * x * percentage), int(MapContextConfig.BlockSize.y * y * percentage)) == 0x00000000 ? true : false;
								}
							}
							_roadMap.dispose();
							_roadMap = null;
							
							initAstar();
						}
						break;
					case "alphamap":
						if(_alphaMap != null)
						{
							_alphaMap.dispose();
							_alphaMap = null;
						}
						_alphaMap = (ResourcePool.getResource(_resource.@className) as Bitmap).bitmapData;
						break;
				}
			}
			_mapReady = true;
			
			init();
		}
		
		protected function resetRoadPath(): void
		{
			if (_negativePath != null)
			{
				_negativePath.splice(0, _negativePath.length);
				_negativePath = null;
			}
			_negativePath = new Array();
			
			var width: uint = int(MapContextConfig.MapSize.x / MapContextConfig.BlockSize.x) + 1;
			var height: uint = int(MapContextConfig.MapSize.y / MapContextConfig.BlockSize.y) + 1;
			
			for (var y: uint = 0; y < height; y++)
			{
				var temp: Array = new Array();
				for (var x: uint = 0; x < width; x++)
				{
					temp.push(true);
				}
				_negativePath.push(temp);
			}
		}
		
		private function initAstar(): void
		{
			_astar = new SilzAstar(_negativePath);
		}
		
		public function init(): void
		{
			initDisplayBuffer();
			
			dispatchEvent(new MapEvent(MapEvent.MAP_READY));
		}
		
		public function initDisplayBuffer(): void
		{
			_displayBufferContainer = new Vector.<DisplayObject>();
			for(var i: int = 0; i<_bufferContainer.length; i++)
			{
				if(_bufferContainer[i] is Bitmap)
				{
					var _bufferData: BitmapData = (_bufferContainer[i] as Bitmap).bitmapData;
					var _displayBufferShape: Shape = new Shape();
					_displayBufferContainer.push(_displayBufferShape);
					addChild(_displayBufferShape);
					
					var _shapePoint: Point = _displayBufferPoint[i] as Point;
					
					_displayBufferShape.graphics.beginBitmapFill(_bufferData, new Matrix(1, 0, 0, 1, _shapePoint.x, _shapePoint.y));
					_displayBufferShape.graphics.drawRect(_shapePoint.x, _shapePoint.y, _bufferData.width, _bufferData.height);
					_displayBufferShape.graphics.endFill();
				}
				else
				{
					var _displayBufferSprite: Sprite = new Sprite();
					_displayBufferContainer.push(_displayBufferSprite);
					addChild(_displayBufferSprite);
					
					var _spritePoint: Point = _displayBufferPoint[i] as Point;
					_bufferContainer[i].x = _spritePoint.x;
					_bufferContainer[i].y = _spritePoint.y;
					_displayBufferSprite.addChild(_bufferContainer[i] as MovieClip);
				}
			}
		}
		
		public function render(enforceRender: Boolean = false): void
		{
			if(_additionalRender != null)
			{
				for(var i: int = 0; i<_additionalRender.length; i++)
				{
					_additionalRender[i].rendering();
				}
			}
			if(!enforceRender && _focus != null && _focus.action == EnumAction.STOP)
			{
				return;
			}
			else
			{
				if (!enforceRender && _centerX == _preCenter.x && _centerY == _preCenter.y)
				{
					return;
				}
				for(var j: int = 0; j<_displayBufferContainer.length; j++)
				{
					_displayBufferContainer[j].x = -screenStartX * _displayBufferDeep[j];
					_displayBufferContainer[j].y = -screenStartY * _displayBufferDeep[j];
				}
				
				_preCenter.x = _centerX;
				_preCenter.y = _centerY;
			}
		}
		
		public function follow(target: MovableComponent, cancel: Boolean = false): void
		{
			if(cancel)
			{
				if(_focus != null)
				{
					_focus.focused = false;
					_focus = null;
				}
				return;
			}
			if(_focus != null)
			{
				_focus.focused = false;
				
				if(target == null)
				{
					_centerX = centerX;
					_centerY = centerY;
				}
			}
			
			_focus = target;
			if(_focus != null)
			{
				_focus.focused = true;
			}
			
			render(true);
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
			if(_focus != null)
			{
				//trace("x: " + _centerX);
//				var offset: Number = (_focus.posX - _focus.lastPosX) / _mainLayer / _mainLayer;
//				_focus.lastPosX = _focus.posX;
//				centerX = _centerX + offset;
				centerX = _focus.posX;
			}
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
			if(_focus != null)
			{
				//trace("y: " + _centerY);
//				var offset: Number = (_focus.posY - _focus.lastPosY) / _mainLayer / _mainLayer;
//				_focus.lastPosY = _focus.posY;
//				centerY = _centerY + offset;
				centerY = _focus.posY;
			}
			return _centerY;
		}
		
		public function set centerY(value:Number):void
		{
			value = Math.max(value, GlobalContextConfig.Height * .5);
			value = Math.min(value, MapContextConfig.MapSize.y - GlobalContextConfig.Height * .5);
			_centerY = value;
		}
		
		public function get screenStartX(): Number
		{
			var _screenStartX: Number = centerX - int(GlobalContextConfig.Width * .5);
			_screenStartX = Math.max(0, _screenStartX);
			_screenStartX = Math.min(MapContextConfig.MapSize.x - GlobalContextConfig.Width, _screenStartX);
			
			return _screenStartX;
		}
		
		public function get screenStartY(): Number
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

		public function get mainLayer():Number
		{
			return _mainLayer;
		}

		public function get focus():MovableComponent
		{
			return _focus;
		}
		
		public function getMapPosition(_pos:Point): Point
		{
			var result: Point = new Point();
			result.x = screenStartX + _pos.x;
			result.y = screenStartY + _pos.y;
			return result;
		}
		
		public function getScreenPosition(_pos:Point): Point
		{
			var result: Point = new Point();
			result.x = _pos.x - screenStartX;
			result.y = _pos.y - screenStartY;
			return result;
		}
		
		public static function mapToBlockPosition(_pos:Point): Point
		{
			var result: Point = new Point();
			result.x = int(_pos.x / MapContextConfig.BlockSize.x);
			result.y = int(_pos.y / MapContextConfig.BlockSize.y);
			return result;
		}
		
		public static function blockToMapPosition(_pos:Point): Point
		{
			var result: Point = new Point();
			result.x = _pos.x * MapContextConfig.BlockSize.x + MapContextConfig.BlockSize.x * .5;
			result.y = _pos.y * MapContextConfig.BlockSize.y + MapContextConfig.BlockSize.y * .5;
			return result;
		}
		
		public static function get AStar(): SilzAstar
		{
			return _astar;
		}

		public function get cameraView():Rectangle
		{
			_cameraView.x = screenStartX > MapContextConfig.MapSize.x - GlobalContextConfig.Width ? MapContextConfig.MapSize.x - GlobalContextConfig.Width : screenStartX;
			_cameraView.y = screenStartY > MapContextConfig.MapSize.y - GlobalContextConfig.Height ? MapContextConfig.MapSize.y - GlobalContextConfig.Height : screenStartY;
			
			_cameraView.width = GlobalContextConfig.Width;
			_cameraView.height = GlobalContextConfig.Height;
			
			return _cameraView;
		}

		public function get cameraCutView():Rectangle
		{
			_cameraCutView.x = cutviewStartX;
			_cameraCutView.y = cutviewStartY;
			_cameraCutView.width = centerX < MapContextConfig.TileSize.x + GlobalContextConfig.Width / 2 ? centerX + GlobalContextConfig.Width / 2 + MapContextConfig.TileSize.x : GlobalContextConfig.Width + MapContextConfig.TileSize.x * 2;
			_cameraCutView.height = centerY < MapContextConfig.TileSize.y + GlobalContextConfig.Height / 2 ? centerY + GlobalContextConfig.Height / 2 + MapContextConfig.TileSize.y : GlobalContextConfig.Height + MapContextConfig.TileSize.y * 2;
			_cameraCutView.width = cutviewStartX > MapContextConfig.MapSize.x - (GlobalContextConfig.Width + MapContextConfig.TileSize.x * 2) ? MapContextConfig.MapSize.x - cutviewStartX : _cameraCutView.width;
			_cameraCutView.height = cutviewStartY > MapContextConfig.MapSize.y - (GlobalContextConfig.Width + MapContextConfig.TileSize.y * 2) ? MapContextConfig.MapSize.y - cutviewStartY : _cameraCutView.height;
			
			return _cameraCutView;
		}

		public function get enableAstar():Boolean
		{
			return _enableAstar;
		}
		
		public function addRender(value: IRender): void
		{
			if(_additionalRender == null)
			{
				_additionalRender = new Vector.<IRender>();
			}
			_additionalRender.push(value);
			value.target = this;
		}
		
		public function removeRender(value: IRender): void
		{
			if(_additionalRender != null)
			{
				var i: int = _additionalRender.indexOf(value);
				if(i != -1)
				{
					_additionalRender[i].target = null;
					_additionalRender.splice(i, 1);
				}
			}
		}
	}
}