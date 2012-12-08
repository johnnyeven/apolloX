package utils.loader
{	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	
	import utils.enum.LoaderStatus;
	import utils.events.LoaderEvent;

	public class XMLLoader extends ItemLoader
	{
		private var _urlLoader: URLLoader;
		
		public function XMLLoader(url:String="", name:String="", loaderConfig:XML=null)
		{
			super(url, name, loaderConfig);
		}
		
		override public function dispose():void
		{
			if(isDispose)
			{
				return;
			}
			super.dispose();
			try
			{
				_urlLoader.close();
			}
			catch(err: Error)
			{
			}
			_urlLoader.removeEventListener(Event.COMPLETE, onLoadComplete);
			_urlLoader.removeEventListener(ProgressEvent.PROGRESS, onLoadProgress);
			_urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, onLoadIOError);
			_urlLoader = null;
		}
		
		override protected function init():void
		{
			super.init();
			_urlLoader = new URLLoader();
			_urlLoader.addEventListener(Event.COMPLETE, onLoadComplete);
			_urlLoader.addEventListener(ProgressEvent.PROGRESS, onLoadProgress);
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onLoadIOError);
		}
		
		override public function load():void
		{
			if(loaderStatus != LoaderStatus.READY)
			{
				return;
			}
			super.load();
			_urlLoader.load(_urlRequest);
		}
		
		override protected function onLoadComplete(evt:Event):void
		{
			super.onLoadComplete(evt);
			_contentLoaded = _urlLoader.data;
			parseResourceXML(XML(_contentLoaded));
			loaderStatus = LoaderStatus.COMPLETE;
			dispatchEvent(new LoaderEvent(LoaderEvent.COMPLETE, this));
		}
		
		protected function parseResourceXML(_xml: XML, _batchLoader: BatchLoader = null): void
		{
			var _nodeName: String;
			var _childXML: XML;
			
			if(_xml.hasOwnProperty("loader"))
			{
				for each(_childXML in _xml.loader.children())
				{
					_nodeName = _childXML.name();
					if(_nodeName == "BatchLoader")
					{
						var _batch:BatchLoader = new BatchLoader(String(_childXML.@name));
						parseResourceXML(_childXML, _batch);
						if(_batchLoader != null)
						{
							_batchLoader.addLoader(_batch);
						}
					}
					else
					{
						var _class: Class = LoaderPool.getLoaderClass(_nodeName);
						var _loader: ItemLoader = new _class("", "", _childXML);
						if(_batchLoader != null)
						{
							_batchLoader.addLoader(_loader);
						}
					}
				}
			}
		}
		
		override public function stop():void
		{
			super.stop();
			if(_urlLoader != null)
			{
				try
				{
					_urlLoader.close();
				}
				catch(err: Error)
				{
				}
			}
		}
		
		override public function pause():void
		{
			super.pause();
			if(_urlLoader != null)
			{
				try
				{
					_urlLoader.close();
				}
				catch(err: Error)
				{
				}
			}
		}
	}
}