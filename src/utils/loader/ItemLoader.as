package utils.loader
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	import utils.GUIDUtils;
	import utils.RequestUtils;
	import utils.StringUtils;
	import utils.enum.LoaderStatus;
	import utils.events.LoaderEvent;
	
	public class ItemLoader extends EventDispatcher
	{
		public var name: String;
		public var url: String;
		public var version: String;
		public var isDispose: Boolean = false;
		public var loaderStatus: int = LoaderStatus.READY;
		protected var _contentLoaded: Object;
		protected var _urlRequest: URLRequest;
		protected var _bytesTotal: uint;
		protected var _bytesLoaded: uint;
		private static var _currentLoader: ItemLoader;
		private static var _loaderQueue: Array = new Array();
		
		public function ItemLoader(url: String = "", name: String = "", loaderConfig: XML = null)
		{
			super(this);
			if(loaderConfig == null)
			{
				this.url = url;
				if(StringUtils.empty(name))
				{
					this.name = GUIDUtils.create();
				}
				else
				{
					this.name = name;
				}
			}
			else
			{
				if(loaderConfig.hasOwnProperty("@name"))
				{
					this.name = loaderConfig.@name;
				}
				else
				{
					this.name = GUIDUtils.create();
				}
				if(loaderConfig.hasOwnProperty("@url"))
				{
					this.url = loaderConfig.@url;
				}
				if(loaderConfig.hasOwnProperty("@version"))
				{
					this.version = loaderConfig.@version;
				}
			}
			LoaderPool.instance.addLoader(this);
			init();
		}
		
		protected function init(): void
		{
			_urlRequest = RequestUtils.getRequestByVersion(url, version);
		}
		
		public function dispose(): void
		{
			if(isDispose)
			{
				return;
			}
			isDispose = true;
			LoaderPool.instance.dispose(name);
			LoaderPool.instance.dispose(url);
			loadNextLoader();
			_contentLoaded = null;
			_urlRequest = null;
			dispatchEvent(new LoaderEvent(LoaderEvent.DISPOSE, this));
		}
		
		public function load(): void
		{
			if(_currentLoader != null && _currentLoader != this)
			{
				_currentLoader.pause();
			}
			_currentLoader = this;
			loaderStatus = LoaderStatus.LOADING;
		}
		
		protected function onLoadComplete(evt: Event): void
		{
			loadNextLoader();
			loaderStatus = LoaderStatus.COMPLETE;
		}
		
		protected function onLoadProgress(evt: ProgressEvent): void
		{
			_bytesLoaded = evt.bytesLoaded;
			_bytesTotal = evt.bytesTotal;
			dispatchEvent(new LoaderEvent(LoaderEvent.PROGRESS, this, _bytesLoaded, _bytesTotal));
		}
		
		protected function onLoadIOError(evt: IOErrorEvent): void
		{
			loadNextLoader();
			loaderStatus = LoaderStatus.ERROR;
			dispatchEvent(new LoaderEvent(LoaderEvent.IO_ERROR, this));
		}
		
		public function loadNextLoader(): void
		{
			if(_currentLoader != this)
			{
				return;
			}
			
			_currentLoader = null;
			if(_loaderQueue.length > 0)
			{
				var _loader: ItemLoader = _loaderQueue.pop() as ItemLoader;
				if(_loader.loaderStatus == LoaderStatus.COMPLETE)
				{
					loadNextLoader();
				}
				else
				{
					_loader.load();
				}
			}
		}
		
		public function stop(): void
		{
			loadNextLoader();
			loaderStatus = LoaderStatus.READY;
		}
		
		public function pause(): void
		{
			_loaderQueue.push(this);
			loaderStatus = LoaderStatus.READY;
		}

		public function get bytesLoaded():uint
		{
			return _bytesLoaded;
		}

		public function get bytesTotal():uint
		{
			return _bytesTotal;
		}

		public function get contentLoaded():Object
		{
			return _contentLoaded;
		}

	}
}