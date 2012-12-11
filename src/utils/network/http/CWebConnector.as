package utils.network.http 
{
	import utils.configuration.ConnectorContextConfig;
	import utils.loader.URLSmartLoader;
	import utils.monitor.CMonitorConsole;
	
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	/**
	 * ...
	 * @author Johnny.EVE
	 */
	public class CWebConnector implements IEventDispatcher 
	{
		//private var coreLoader: URLSmartLoader;
		private static const MAX_LOADER: uint = 3;
		private var loaderContainer: Vector.<URLSmartLoader>;
		private var eventDispatcher: EventDispatcher;
		protected var callback: Function;
		protected static var instance: CWebConnector;
		protected static var allowInstance: Boolean = false;
		
		public function CWebConnector() 
		{
			if (!allowInstance)
			{
				throw new IllegalOperationError("CWebConnector不允许实例化");
			}
			eventDispatcher = new EventDispatcher(this);
			loaderContainer = new Vector.<URLSmartLoader>();
		}
		
		private function getAvailableLoader(): URLSmartLoader
		{
			for (var key: String in loaderContainer)
			{
				if (!(loaderContainer[key] as URLSmartLoader).isLoading)
				{
					return (loaderContainer[key] as URLSmartLoader);
				}
				else
				{
					if (loaderContainer.length > MAX_LOADER)
					{
						loaderContainer[key] = null;
						delete loaderContainer[key];
					}
				}
			}
			var _loader: URLSmartLoader = new URLSmartLoader();
			_loader.dataFormat = URLLoaderDataFormat.TEXT;
			_loader.addEventListener(Event.COMPLETE, onDataCallback, false, 0, true);
			_loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler, false, 0, true);
			_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler, false, 0, true);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler, false, 0, true);
			loaderContainer.push(_loader);
			return _loader;
		}
		
		private function ioErrorHandler(e:IOErrorEvent):void 
		{
			CONFIG::DebugMode
			{
				trace("Error: CWebConnector.as[74] IO_ERROR - error name: " + e.type + ", error message: " + e.text);
				CMonitorConsole.getInstance().log("Error: CWebConnector.as[74] IO_ERROR - error name: " + e.type + ", error message: " + e.text);
			}
			//dispatchEvent(e);
		}
		
		private function securityErrorHandler(e:SecurityErrorEvent):void 
		{
			dispatchEvent(e);
		}
		
		private function httpStatusHandler(e:HTTPStatusEvent):void 
		{
			dispatchEvent(e);
		}
		
		public function addCallback(callback: Function): void
		{
			this.callback = callback;
		}
		
		protected function onDataCallback(evt: Event): void
		{
			var loader: URLSmartLoader = evt.target as URLSmartLoader;
			process(loader);
		}
		
		private function process(_loader: URLSmartLoader): void
		{
			var data: String = _loader.data as String;
			CONFIG::DebugMode
			{
				trace(data);
				CMonitorConsole.getInstance().log(data);
			}
			if (data)
			{
				try
				{
					var json: Object = JSON.parse(data);
				}
				catch (err: Error)
				{
					CONFIG::DebugMode
					{
						trace("Error: CWebConnector.as[125] JSON.parse error - error name: " + err.name + ", error message: " + err.message);
						CMonitorConsole.getInstance().log("Error: CWebConnector.as[125] JSON.parse error - error name: " + err.name + ", error message: " + err.message);
					}
				}
				_loader.isLoading = false;
				var flag: uint = parseInt(json.flag);
				if (callback != null)
				{
					callback(flag, json);
				}
			}
			else
			{
				CONFIG::DebugMode
				{
					trace("Warning: URLLoader.data is empty");
					CMonitorConsole.getInstance().log("Warning: URLLoader.data is empty");
				}
			}
		}
		
		public function send(url: String, variables: URLVariables): void
		{
			var path: String = ConnectorContextConfig.serverPath + url;
			var request: URLRequest = new URLRequest(path);
			if (variables != null)
			{
				request.data = variables;
				request.method = URLRequestMethod.POST;
				try
				{
					var coreLoader: URLSmartLoader = getAvailableLoader();
					coreLoader.load(request);
					coreLoader.isLoading = true;
					CONFIG::DebugMode
					{
						trace("Message: URLLoader.load " + path);
						CMonitorConsole.getInstance().log("Message: URLLoader.load " + path);
					}
				}
				catch (err: Error)
				{
					CONFIG::DebugMode
					{
						trace("Error: CWebConnector.as[163] URLLoader.load error - error name: " + err.name + ", error message: " + err.message);
						CMonitorConsole.getInstance().log("Error: CWebConnector.as[163] URLLoader.load error - error name: " + err.name + ", error message: " + err.message);
					}
				}
			}
			else
			{
				CONFIG::DebugMode
				{
					trace("Warning: CWebConnector.as[172] URLVariables is empty");
					CMonitorConsole.getInstance().log("Warning: CWebConnector.as[172] URLVariables is empty");
				}
			}
		}
		
		public static function getInstance(): CWebConnector
		{
			if (instance == null)
			{
				allowInstance = true;
				instance = new CWebConnector();
				allowInstance = false;
			}
			return instance;
		}
		
		/* INTERFACE flash.events.IEventDispatcher */
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void 
		{
			eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void 
		{
			eventDispatcher.removeEventListener(type, listener, useCapture);
		}
		
		public function dispatchEvent(event:Event):Boolean 
		{
			return eventDispatcher.dispatchEvent(event);
		}
		
		public function hasEventListener(type:String):Boolean 
		{
			return eventDispatcher.hasEventListener(type);
		}
		
		public function willTrigger(type:String):Boolean 
		{
			return eventDispatcher.willTrigger(type);
		}
		
	}

}