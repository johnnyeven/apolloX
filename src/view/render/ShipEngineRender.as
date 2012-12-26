package view.render
{
	import enum.EnumAction;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	import flash.geom.Point;
	
	import mediator.space.SpaceBackgroundMediator;
	
	import utils.GameManager;
	import utils.events.LoaderEvent;
	import utils.liteui.core.Component;
	import utils.loader.LoaderPool;
	import utils.loader.ResourceLoadManager;
	import utils.loader.XMLLoader;
	import utils.resource.ResourcePool;
	
	import view.space.background.SpaceBackgroundComponent;
	import view.space.ship.ShipComponent;

	public class ShipEngineRender extends Render
	{
		private var _shipComponent: ShipComponent;
		private var _backgroundComponent: SpaceBackgroundComponent;
		private var _shipResourceId: int;
		private var _engineContainer: Sprite;
		private var _configXML: XML;
		private var _engines: Vector.<MovieClip>;
		private var _engineSmoke: Vector.<MovieClip>;
		private var _engineSmokePos: Vector.<Point>;
		private var _enginePosition: Array;
		private var _effectReady: Boolean = false;
		private var _preAction: int;
		private var _isEngineOn: Boolean = false;
		private var _smokeTrigger: int = 1;
		
		public function ShipEngineRender()
		{
			super();
			var _mediator: SpaceBackgroundMediator = ApplicationFacade.getInstance().retrieveMediator(SpaceBackgroundMediator.NAME) as SpaceBackgroundMediator;
			_backgroundComponent = _mediator.component;
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
						
						if(_smokeTrigger % 3 == 0)
						{
							var _smoke: MovieClip = ResourcePool.getResource("space.smoke.EngineSmoke") as MovieClip;
							_smoke.x = _engines[j].x;
							_smoke.y = _engines[j].y;
							_engineSmoke.push(_smoke);
							var _posScene: Point = _backgroundComponent.getMapPosition(new Point(_smoke.x + _shipComponent.x, _smoke.y + _shipComponent.y));
							_engineSmokePos.push(_posScene);
							_engineContainer.addChild(_smoke);
						}
					}
					if(_smokeTrigger % 3 == 0)
					{
						_smokeTrigger = 1;
					}
					else
					{
						_smokeTrigger++
					}
				}
				for(var m: int = 0; m<_engineSmoke.length; m++)
				{
					_engineSmoke[m].x = _engineSmokePos[m].x - _shipComponent.posX;
					_engineSmoke[m].y = _engineSmokePos[m].y - _shipComponent.posY;
					if(_engineSmoke[m].currentFrame >= _engineSmoke[m].totalFrames)
					{
						_engineContainer.removeChild(_engineSmoke[m]);
						_engineSmoke.splice(m, 1);
						_engineSmokePos.splice(m, 1);
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
			if(_engineSmoke != null)
			{
				_engineSmoke.splice(0, _engineSmoke.length);
				_engineSmoke = null;
			}
			if(_engineSmokePos != null)
			{
				_engineSmokePos.splice(0, _engineSmokePos.length);
				_engineSmokePos = null;
			}
			_engines = new Vector.<MovieClip>();
			_engineSmoke = new Vector.<MovieClip>();
			_engineSmokePos = new Vector.<Point>();
			
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