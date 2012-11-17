package utils.loader
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.system.LoaderContext;
	import flash.system.ApplicationDomain;
	
	import utils.enum.LoaderStatus;
	import utils.events.LoaderEvent;

	public class ImageLoader extends ItemLoader
	{
		private var _loader: Loader;
		private var _bitmapData: BitmapData;
		public var disposeAfterLoaded: Boolean = false;
		
		public function ImageLoader(url: String="", name: String="", loaderConfig: XML=null, disposeAfterLoaded: Boolean = false)
		{
			super(url, name, loaderConfig);
			this.disposeAfterLoaded = disposeAfterLoaded;
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
			_bitmapData = new BitmapData(_loader.content.width, _loader.content.height);
			_bitmapData.draw(_loader.content);
			if(disposeAfterLoaded)
			{
				dispose();
			}
			dispatchEvent(new LoaderEvent(LoaderEvent.COMPLETE, this));
		}
		
		override public function load(): void
		{
			if(loaderStatus != LoaderStatus.READY)
			{
				return;
			}
			super.load();
			var _loaderContext: LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			_loader.load(_urlRequest, _loaderContext);
		}
		
		public function get image(): Bitmap
		{
			return new Bitmap(_bitmapData);
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