package utils.loader
{
	/**
	 * ...
	 * @author john
	 */
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	import utils.events.LoaderEvent;
	import utils.enum.LoaderStatus;

	public class ClassLoader extends ItemLoader
	{
		private var _loader:Loader;

		//构造函数
		public function ClassLoader (url: String = "", name: String = "", loaderConfig: XML = null) {
			super(url, name, loaderConfig);
		}
		
		override public function dispose(): void
		{
			if(isDispose)
			{
				return;
			}
			super.dispose();
			try
			{
				_loader.unloadAndStop(false);
			}
			catch(err: Error)
			{
				_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoadComplete);
				_loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onLoadProgress);
				_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onLoadIOError);
				_loader = null;
			}
		}
		
		override protected function init(): void
		{
			super.init();
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoadProgress);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadIOError);
		}
		
		override protected function onLoadComplete(evt: Event): void
		{
			super.onLoadComplete(evt);
			_contentLoaded = _loader.content;
			dispatchEvent(new LoaderEvent(LoaderEvent.COMPLETE, this));
		}
		
		//加载
		override public function load (): void
		{
			if(loaderStatus != LoaderStatus.READY)
			{
				return;
			}
			super.load();
			var _loaderContext: LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			_loader.load(_urlRequest, _loaderContext);
		}
		
		//加载字节
		public function loadBytes (bytes:ByteArray,lc:LoaderContext = null):void {
			_loader = new Loader;
			_loader.loadBytes (bytes,lc);
		}
		
		//获取定义
		public function getClass (className:String): Class {
			return _loader.contentLoaderInfo.applicationDomain.getDefinition(className) as Class;
		}
		
		//是否含有该定义
		public function hasClass (className:String):Boolean {
			return _loader.contentLoaderInfo.applicationDomain.hasDefinition(className);
		}
		
		public function getApplicationDomain (): ApplicationDomain {
			return _loader.contentLoaderInfo.applicationDomain;
		}
		
		override public function stop(): void
		{
			super.stop();
			if(_loader != null)
			{
				try
				{
					_loader.close();
				}
				catch(err: Error)
				{
					
				}
			}
		}
		
		override public function pause(): void
		{
			super.pause();
			if(_loader != null)
			{
				try
				{
					_loader.close();
				}
				catch(err: Error)
				{
					
				}
			}
		}
	}
}