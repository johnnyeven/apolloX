package utils.loader
{
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.Dictionary;
	
	import utils.enum.LoaderStatus;
	import utils.events.LoaderEvent;

	public class ResourceLoadManager
	{
		public static const SHOW_PROGRESSBAR_NOTE: String = "show_progressbar_note";
		public static const HIDE_PROGRESSBAR_NOTE: String = "hide_progressbar_note";
		public static const SET_PROGRESSBAR_TITLE_NOTE: String = "set_progressbar_title_note";
		public static const SET_PROGRESSBAR_PERCENT_NOTE: String = "set_progressbar_percent_note";
		
		private static var _showLoaderBarIndex: Dictionary = new Dictionary();
		private static var _completeCallbackIndex: Dictionary = new Dictionary();
		private static var _errorCallbackIndex: Dictionary = new Dictionary();
		private static var _progressCallbackIndex: Dictionary = new Dictionary();
		
		public function ResourceLoadManager()
		{
		}
		
		public static function load(url: String, showLoaderBar: Boolean = false, title: String = "", completeCallback: Function = null, progressCallback: Function = null, errorCallback: Function = null): void
		{
			var _loader: ItemLoader = LoaderPool.instance.initLoader(url);
			if(_loader == null)
			{
				throw new Error("资源名称不合法，url=" + url);
			}
			if(completeCallback != null)
			{
				if(_completeCallbackIndex[url] == null)
				{
					_completeCallbackIndex[url] = new Array();
				}
				_completeCallbackIndex[url].push(completeCallback);
			}
			if(progressCallback != null)
			{
				if(_progressCallbackIndex[url] == null)
				{
					_progressCallbackIndex[url] = new Array();
				}
				_progressCallbackIndex[url].push(progressCallback);
			}
			if(errorCallback != null)
			{
				if(_errorCallbackIndex[url] == null)
				{
					_errorCallbackIndex[url] = new Array();
				}
				_errorCallbackIndex[url].push(errorCallback);
			}
			_showLoaderBarIndex[url] = showLoaderBar;
			
			if(_loader.loaderStatus == LoaderStatus.COMPLETE)
			{
				resetIndex(url);
				if(completeCallback != null)
				{
					if(_loader is BatchLoader)
					{
						completeCallback(new LoaderEvent(LoaderEvent.COMPLETE, _loader, _loader.bytesLoaded, _loader.bytesTotal, (_loader as BatchLoader).loaderIndex, (_loader as BatchLoader).loaderCount));
					}
					else
					{
						completeCallback(new LoaderEvent(LoaderEvent.COMPLETE, _loader, _loader.bytesLoaded, _loader.bytesTotal));
					}
				}
			}
			else if(_loader.loaderStatus != LoaderStatus.LOADING)
			{
				_loader.addEventListener(LoaderEvent.COMPLETE, onLoadCompelete);
				_loader.addEventListener(LoaderEvent.PROGRESS, onLoadProgress);
				_loader.addEventListener(LoaderEvent.IO_ERROR, onLoadIOError);
				
				if(showLoaderBar)
				{
					ApplicationFacade.getInstance().sendNotification(SHOW_PROGRESSBAR_NOTE);
					ApplicationFacade.getInstance().sendNotification(SET_PROGRESSBAR_TITLE_NOTE, title);
				}
				_loader.load();
			}
			else
			{
				if(_loader is BatchLoader)
				{
					progressCallback(new LoaderEvent(LoaderEvent.COMPLETE, _loader, _loader.bytesLoaded, _loader.bytesTotal, (_loader as BatchLoader).loaderIndex, (_loader as BatchLoader).loaderCount));
				}
				else
				{
					progressCallback(new LoaderEvent(LoaderEvent.COMPLETE, _loader, _loader.bytesLoaded, _loader.bytesTotal));
				}
			}
		}
		
		private static function resetIndex(key: String): void
		{
			delete _completeCallbackIndex[key];
			delete _progressCallbackIndex[key];
			delete _errorCallbackIndex[key];
			delete _showLoaderBarIndex[key]
		}
		
		private static function removeListener(_loader: ItemLoader): void
		{
			_loader.removeEventListener(LoaderEvent.COMPLETE, onLoadCompelete);
			_loader.removeEventListener(LoaderEvent.PROGRESS, onLoadProgress);
			_loader.removeEventListener(LoaderEvent.IO_ERROR, onLoadIOError);
		}
		
		private static function onLoadCompelete(evt: LoaderEvent): void
		{
			var _loader: ItemLoader = evt.loader;
			var _index: String = getLoaderIndex(_loader);
			removeListener(_loader);
			
			if(_showLoaderBarIndex[_index])
			{
				ApplicationFacade.getInstance().sendNotification(HIDE_PROGRESSBAR_NOTE);
			}
			
			for each(var _callback: Function in _completeCallbackIndex[_index])
			{
				_callback(evt);
			}
			resetIndex(_index);
		}
		
		private static function onLoadIOError(evt: LoaderEvent): void
		{
			var _loader: ItemLoader = evt.loader;
			var _index: String = getLoaderIndex(_loader);
			removeListener(_loader);
			
			if(_showLoaderBarIndex[_index])
			{
				ApplicationFacade.getInstance().sendNotification(HIDE_PROGRESSBAR_NOTE);
			}
			
			for each(var _callback: Function in _errorCallbackIndex[_index])
			{
				_callback(evt);
			}
			resetIndex(_index);
		}
		
		private static function onLoadProgress(evt: LoaderEvent): void
		{
			var _loader: ItemLoader = evt.loader;
			var _index: String = getLoaderIndex(_loader);
			
			if(_showLoaderBarIndex[_index])
			{
				ApplicationFacade.getInstance().sendNotification(SET_PROGRESSBAR_PERCENT_NOTE, Math.floor(evt.bytesLoaded / evt.bytesTotal) * 100);
			}
			
			for each(var _callback: Function in _progressCallbackIndex[_index])
			{
				_callback(evt);
			}
		}
		
		private static function getLoaderIndex(_loader: ItemLoader): String
		{
			if(_completeCallbackIndex[_loader.name] != null)
			{
				return _loader.name;
			}
			else if(_completeCallbackIndex[_loader.url] != null)
			{
				return _loader.url;
			}
			return "";
		}
	}
}