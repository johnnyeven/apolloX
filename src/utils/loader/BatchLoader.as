package utils.loader
{
	import utils.enum.LoaderStatus;
	import utils.events.LoaderEvent;
	import utils.loader.LoaderPool;

	public class BatchLoader extends ItemLoader
	{
		private var _childLoader: Array;
		private var _currentLoader: ItemLoader;
		private var _childLoaderIndex: int = 0;
		private var _itemLoaderList: Array;
		
		public function BatchLoader(name:String = null)
		{
			this.name = name;
			_childLoader = new Array();
			_itemLoaderList = new Array();
			
			LoaderPool.instance.addLoader(this);
		}
		
		override public function dispose():void
		{
			if(isDispose)
			{
				return;
			}
			stop();
			_currentLoader = null;
			_childLoader = null;
			_itemLoaderList = null;
			
			isDispose = true;
		}
		
		public function addLoader(child: ItemLoader): void
		{
			_childLoader.push(child);
			child.addEventListener(LoaderEvent.DISPOSE, onLoaderDispose);
		}
		
		protected function onLoaderDispose(evt: LoaderEvent): void
		{
			var _loader: ItemLoader = evt.loader;
			_loader.removeEventListener(LoaderEvent.DISPOSE, onLoaderDispose);
			var index: int = _childLoader.indexOf(_loader);
			if(index != -1)
			{
				_childLoader.splice(index, 1);
			}
		}
		
		override public function load():void
		{
			loaderStatus = LoaderStatus.LOADING;
			_itemLoaderList = getItemLoaderList();
			_childLoaderIndex = 0;
			_bytesLoaded = 0;
			_bytesTotal = 0;
			loadNext();
		}
		
		public function getItemLoaderList(): Array
		{
			var child: ItemLoader;
			var loaderList: Array = new Array();
			for(var i: int = 0; i<_childLoader.length; i++)
			{
				child = _childLoader[i];
				if(child is BatchLoader)
				{
					loaderList = loaderList.concat((child as BatchLoader).getItemLoaderList());
				}
				else
				{
					loaderList.push(child);
				}
			}
			return loaderList;
		}
		
		protected function loadNext(): void
		{
			removeCurrentLoaderListener();
			if(_childLoaderIndex >= _itemLoaderList.length)
			{
				_childLoaderIndex = _itemLoaderList.length;
				loaderStatus = LoaderStatus.COMPLETE;
				dispatchEvent(new LoaderEvent(LoaderEvent.COMPLETE, this, 1, 1, _childLoaderIndex, _itemLoaderList.length));
				return;
			}
			_currentLoader = _itemLoaderList[_childLoaderIndex];
			
			if(_currentLoader.loaderStatus == LoaderStatus.COMPLETE)
			{
				_childLoaderIndex++;
				dispatchProgressEvent();
				loadNext();
				return;
			}
			
			_currentLoader.addEventListener(LoaderEvent.COMPLETE, onLoaderComplete, false, 0, true);
			_currentLoader.addEventListener(LoaderEvent.PROGRESS, onLoaderProgress, false, 0, true);
			_currentLoader.addEventListener(LoaderEvent.IO_ERROR, onLoaderIOError, false, 0, true);
			
			if(_currentLoader.loaderStatus == LoaderStatus.LOADING)
			{
				_childLoaderIndex++;
				dispatchProgressEvent();
				return;
			}
			_childLoaderIndex++;
			dispatchProgressEvent();
			_currentLoader.load();
		}
		
		private function dispatchProgressEvent(): void
		{
			dispatchEvent(new LoaderEvent(LoaderEvent.PROGRESS, this, _bytesLoaded, _bytesTotal, _childLoaderIndex, _itemLoaderList.length));
		}
		
		private function removeCurrentLoaderListener(): void
		{
			if(_currentLoader != null)
			{
				_currentLoader.removeEventListener(LoaderEvent.COMPLETE, onLoaderComplete);
				_currentLoader.removeEventListener(LoaderEvent.PROGRESS, onLoaderProgress);
				_currentLoader.removeEventListener(LoaderEvent.IO_ERROR, onLoaderIOError);
				_currentLoader = null;
			}
		}
		
		protected function onLoaderComplete(evt: LoaderEvent): void
		{
			loadNext();
		}
		
		protected function onLoaderProgress(evt: LoaderEvent): void
		{
			_bytesLoaded = _currentLoader.bytesLoaded;
			_bytesTotal = _currentLoader.bytesTotal;
			dispatchProgressEvent();
		}
		
		protected function onLoaderIOError(evt: LoaderEvent): void
		{
			loaderStatus = LoaderStatus.ERROR;
			dispatchEvent(new LoaderEvent(LoaderEvent.IO_ERROR, this, _bytesLoaded, _bytesTotal, _childLoaderIndex, _itemLoaderList.length));
		}
		
		override public function stop():void
		{
			loaderStatus = LoaderStatus.READY;
			if(_currentLoader != null)
			{
				_currentLoader.stop();
			}
			removeCurrentLoaderListener();
		}
		
		override public function pause():void
		{
			loaderStatus = LoaderStatus.READY;
			if(_currentLoader != null)
			{
				_currentLoader.pause();
			}
			removeCurrentLoaderListener();
		}
		
		public function get loaderIndex(): int
		{
			return _childLoaderIndex;
		}
		
		public function get loaderCount(): int
		{
			return _itemLoaderList.length;
		}
	}
}