package view.space.background
{
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import utils.algorithms.SilzAstar;
	import utils.events.LoaderEvent;
	import utils.language.LanguageManager;
	import utils.liteui.core.Component;
	import utils.loader.ResourceLoadManager;
	import utils.loader.XMLLoader;
	
	public class SpaceBackgroundComponent extends Component
	{
		private var _id: String = "default";
		private var _xmlLoader: XMLLoader;
		private static var _astar: SilzAstar;
		private var _buffer: BitmapData;
		private var _displayBuffer: Shape;
		private var _preCenter: Point;
		private var _preStart: Point;
		private var _center: Point;
		private var _negativePath: Array;
		private var _mapReady: Boolean;
		private var _screenStartX: int;
		private var _screenStartY: int;
		private var _cameraView: Rectangle;
		private var _cameraCutView: Rectangle;
		protected var _mapXML: XML;
		
		public function SpaceBackgroundComponent()
		{
			super();
			
			_preCenter = new Point();
			_preStart = new Point(-1, -1);
			_center = new Point();
			_negativePath = new Array();
			_mapReady = false;
			_cameraView = new Rectangle();
			_cameraCutView = new Rectangle();
		}
		
		protected function load(): void
		{
			if(_xmlLoader == null)
			{
				_xmlLoader = new XMLLoader("resources/background/xml/" + id + ".xml");
				_xmlLoader.addEventListener(LoaderEvent.COMPLETE, onXMLLoadComplete);
				_xmlLoader.addEventListener(LoaderEvent.PROGRESS, onXMLLoadProgress);
				_xmlLoader.addEventListener(LoaderEvent.IO_ERROR, onXMLLoadIOError);
				//_xmlLoader.version = VersionUtils.getVersion("resource_config");
				
				ApplicationFacade.getInstance().sendNotification(ResourceLoadManager.SET_PROGRESSBAR_TITLE_NOTE, LanguageManager.getInstance().lang("load_resource_config"));
				ApplicationFacade.getInstance().sendNotification(ResourceLoadManager.SHOW_PROGRESSBAR_NOTE);
				
				_xmlLoader.load();
			}
		}
		
		protected function onXMLLoadComplete(evt: LoaderEvent): void
		{
			ApplicationFacade.getInstance().sendNotification(ResourceLoadManager.HIDE_PROGRESSBAR_NOTE);
			removeXMLLoaderListener();
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

		public function get id():String
		{
			return _id;
		}

		public function set id(value:String):void
		{
			_id = value;
			load();
		}

	}
}