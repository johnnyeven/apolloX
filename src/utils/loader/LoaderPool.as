package utils.loader
{
	import flash.display.DisplayObject;
	import flash.errors.IllegalOperationError;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import utils.StringUtils;
	
	public class LoaderPool
	{
		private static var _instance: LoaderPool;
		private static var _allowInstance: Boolean = false;
		private static var _pool: Dictionary;
		
		public function LoaderPool()
		{
			if(_allowInstance)
			{
				_pool = new Dictionary();
			}
			else
			{
				throw new IllegalOperationError("You cant get instance trough constructor.");
			}
		}
		
		public static function get instance(): LoaderPool
		{
			if(_instance == null)
			{
				_allowInstance = true;
				_instance = new LoaderPool();
				_allowInstance = false;
			}
			return _instance;
		}
		
		public function addLoader(_loader: ItemLoader): void
		{
			dispose(_loader.name);
			dispose(_loader.url);
			
			if(!StringUtils.empty(_loader.name))
			{
				_pool[_loader.name] = _loader;
			}
			else if(!StringUtils.empty(_loader.url))
			{
				_pool[_loader.url] = _loader;
			}
		}
		
		public function dispose(_key: String): void
		{
			var _itemLoader: ItemLoader = _pool[_key] as ItemLoader;
			if(_itemLoader != null)
			{
				_itemLoader.dispose();
				delete _pool[_key];
			}
		}
		
		public function getLoader(key: String): ItemLoader
		{
			return _pool[key] as ItemLoader;
		}
		
		public function getContent(key: String): Object
		{
			var _loader: ItemLoader = getLoader(key);
			return _loader == null ? null : _loader.contentLoaded;
		}
		
		public function createLoader(url: String): ItemLoader
		{
			var _loader: ItemLoader;
			if(url.search(".png") != -1)
			{
				_loader = new ImageLoader(url);
			}
			else if(url.search(".swf"))
			{
				_loader = new ClassLoader(url);
			}
			else if(url.search(".xml"))
			{
				_loader = new XMLLoader(url);
			}
			return _loader;
		}
		
		public function initLoader(url: String): ItemLoader
		{
			var _loader: ItemLoader = getLoader(url);
			if(_loader == null)
			{
				_loader = createLoader(url);
			}
			return _loader;
		}
		
		public static function getLoaderClass(className: String): Class
		{
			switch(className)
			{
				case "BatchLoader":
					return BatchLoader;
				case "ImageLoader":
					return ImageLoader;
				case "ClassLoader":
					return ClassLoader;
				case "XMLLoader":
					return XMLLoader;
				default:
					return null;
			}
		}
	}
}