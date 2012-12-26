package view.render
{
	import enum.EnumAction;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	
	import utils.events.LoaderEvent;
	import utils.liteui.core.Component;
	import utils.loader.LoaderPool;
	import utils.loader.ResourceLoadManager;
	import utils.loader.XMLLoader;
	import utils.resource.ResourcePool;
	
	import view.space.ship.ShipComponent;

	public class ShipEngineRender extends Render
	{
		private var _shipComponent: ShipComponent;
		private var _shipResourceId: int;
		private var _engineContainer: Sprite;
		private var _configXML: XML;
		private var _engines: Vector.<MovieClip>;
		private var _enginePosition: Array;
		private var _effectReady: Boolean = false;
		private var _preAction: int;
		private var _isEngineOn: Boolean = false;
		
		public function ShipEngineRender()
		{
			super();
		}
		
		private function onConfigLoaded(evt: LoaderEvent): void
		{
			var _loader: XMLLoader = evt.loader as XMLLoader;
			_configXML = _loader.configXML;
			
			if(_configXML != null && _configXML.hasOwnProperty("engines") && _configXML.engines.hasOwnProperty("engine"))
			{
//				if(LoaderPool.instance.getLoader("ship" + _shipResourceId + "_resource") != null)
//				{
//					init();
//				}
//				else
//				{
				ResourceLoadManager.load("ship" + _shipResourceId + "_resource", false, "", init);
//				}
			}
		}
		
		override public function rendering(force:Boolean=false):void
		{
			if(_effectReady)
			{
				if(_preAction != _shipComponent.action)
				{
					for(var i: int = 0; i<_engines.length; i++)
					{
						if(!_engines[i].visible)
						{
							_engines[i].visible = true;
						}
						if(_shipComponent.action == EnumAction.MOVE)
						{
							_engines[i].gotoAndPlay("open");
							_isEngineOn = true;
						}
						else if(_shipComponent.action == EnumAction.STOP)
						{
							_engines[i].gotoAndPlay("close");
							_isEngineOn = false;
						}
					}
					_preAction = _shipComponent.action;
				}
				
				if(_isEngineOn)
				{
					for(var j: int = 0; j<_engines.length; j++)
					{
						_engines[j].rotation = _enginePosition[_shipComponent.direction-1][0];
						_engines[j].x = _enginePosition[_shipComponent.direction-1][1];
						_engines[j].y = _enginePosition[_shipComponent.direction-1][2];
					}
				}
			}
		}
		
		override public function set target(value:Component):void
		{
			super.target = value;
			if(value is ShipComponent)
			{
				_shipComponent = value as ShipComponent;
				_engineContainer = _shipComponent.effectLayer;
				_shipResourceId = _shipComponent.info.shipResource;
				_preAction = _shipComponent.action;
				ResourceLoadManager.load("resources/ship/xml/ship" + _shipResourceId + ".xml", false, "", onConfigLoaded);
			}
			else
			{
				throw new IllegalOperationError("ShipEngineRender must use in ShipComponent");
			}
		}
		
		private function init(evt: LoaderEvent = null): void
		{
			createEngine();
			initEnginePosition();
		}
		
		private function createEngine(): void
		{
			if(_engines != null)
			{
				_engines.splice(0, _engines.length);
				_engines = null;
			}
			_engines = new Vector.<MovieClip>();
			
			var _engine: MovieClip;
			for each(var child: XML in _configXML.engines.engine)
			{
				_engine = ResourcePool.getResource(child["@class"]) as MovieClip;
				_engine.visible = false;
				_engineContainer.addChild(_engine);
				_engines.push(_engine);
			}
		}
		
		private function initEnginePosition(): void
		{
			if(_enginePosition != null)
			{
				_enginePosition.splice(0, _enginePosition.length);
				_enginePosition = null;
			}
			_enginePosition = new Array();
			
			if(_configXML.engines.engine.hasOwnProperty("frame"))
			{
				for each(var child: XML in _configXML.engines.engine.frame)
				{
					_enginePosition.push([child.@angle, child.@x, child.@y]);
				}
			}
			_effectReady = true;
		}
	}
}