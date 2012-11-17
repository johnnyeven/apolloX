package utils.resource
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import utils.StringUtils;
	import utils.events.LoaderEvent;
	import utils.loader.ResourceLoadManager;
	import utils.network.data.ResourcePoolLoaderParameter;

	public class ResourcePool
	{
		private static var _pool: Dictionary = new Dictionary();
		private static var _resourceLoadedIndex: Dictionary = new Dictionary();
		
		public function ResourcePool()
		{
			
		}
		
		public static function getResource(className: String): DisplayObject
		{
			var _resource: DisplayObject = getResourceFromPool(className);
			if(_resource == null)
			{
				try
				{
					var _class: Class = getDefinitionByName(className) as Class;
					_resource = new _class();
					if(_resource is BitmapData)
					{
						_resource = new Bitmap(_resource as BitmapData);
					}
				}
				catch(err: Error)
				{
					
				}
			}
			return _resource;
		}
		
		public static function getResourceByLoader(url: String, className: String, callback: Function = null): DisplayObject
		{
			var _resource: DisplayObject = getResourceFromPool(className);
			if(_resource == null)
			{
				if(StringUtils.empty(url))
				{
					return null;
				}
				
				if(_resourceLoadedIndex[url] == null)
				{
					_resourceLoadedIndex[url] = new Array();
				}
				var _parameter: ResourcePoolLoaderParameter = new ResourcePoolLoaderParameter();
				_parameter.url = url;
				_parameter.className = className;
				_parameter.displayObject = new Sprite();
				_parameter.callback = callback;
				_resourceLoadedIndex[url].push(_parameter);
				
				if(_resourceLoadedIndex[url].length == 1)
				{
					ResourceLoadManager.load(url, false, "", onResourceLoaded, null, onResourceIOError);
				}
			}
			return _resource;
		}
		
		private static function onResourceLoaded(evt: LoaderEvent): void
		{
			var _class: Class;
			var _display: DisplayObject;
			var _url: String = evt.loader.url;
			var _parameterArray: Array = _resourceLoadedIndex[_url];
			if(_parameterArray != null)
			{
				for each(var _parameter: ResourcePoolLoaderParameter in _parameterArray)
				{
					_class = getDefinitionByName(_parameter.className) as Class;
					_display = new _class();
					if(_parameter.callback != null)
					{
						_parameter.callback(_display);
						_parameter.displayObject = null;
					}
					else
					{
						_parameter.displayObject.addChild(_display);
					}
					_parameter.callback = null;
				}
				delete _resourceLoadedIndex[_url];
			}
		}
		
		private static function onResourceIOError(evt: LoaderEvent): void
		{
			delete _resourceLoadedIndex[evt.loader.url];
		}
		
		private static function getResourceFromPool(key: String): DisplayObject
		{
			if(_pool[key] != null)
			{
				return _pool[key] as DisplayObject;
			}
			return null;
		}
	}
}