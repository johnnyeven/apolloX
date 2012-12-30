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
	import view.space.effects.rocket.EffectRocketComponent;
	import view.space.ship.ShipComponent;

	public class RocketEngineRender extends Render
	{
		private var _rocketComponent: EffectRocketComponent;
		private var _backgroundComponent: SpaceBackgroundComponent;
		private var _shipResourceId: int;
		private var _engineContainer: Sprite;
		private var _configXML: XML;
		private var _engineSmoke: Vector.<MovieClip>;
		private var _engineSmokePos: Vector.<Point>;
		private var _enginePosition: Array;
		private var _effectReady: Boolean = false;
		private var _preAction: int;
		private var _isEngineOn: Boolean = false;
		private var _smokeTrigger: int = 1;
		
		public function RocketEngineRender()
		{
			super();
			var _mediator: SpaceBackgroundMediator = ApplicationFacade.getInstance().retrieveMediator(SpaceBackgroundMediator.NAME) as SpaceBackgroundMediator;
			_backgroundComponent = _mediator.component;
		}
		
		override public function rendering(force:Boolean=false):void
		{
			if(_effectReady)
			{
				if(_smokeTrigger % 2 == 0)
				{
					var _smoke: MovieClip = ResourcePool.getResource(_configXML.smoke.texture[0]["@class"]) as MovieClip;
					_smoke.x = _rocketComponent.x;
					_smoke.y = _rocketComponent.y;
					_engineSmoke.push(_smoke);
					var _posScene: Point = _backgroundComponent.getMapPosition(new Point(_smoke.x, _smoke.y));
					_engineSmokePos.push(_posScene);
					_engineContainer.addChild(_smoke);
					
					_smokeTrigger = 1;
				}
				else
				{
					_smokeTrigger++
				}
				for(var m: int = 0; m<_engineSmoke.length; m++)
				{
					_engineSmoke[m].x = _engineSmokePos[m].x - _rocketComponent.posX;
					_engineSmoke[m].y = _engineSmokePos[m].y - _rocketComponent.posY;
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
			if(value is EffectRocketComponent)
			{
				_rocketComponent = value as EffectRocketComponent;
				_engineContainer = _rocketComponent.effectLayer;
				_shipResourceId = _rocketComponent.info.resourceId;
				_configXML = _rocketComponent.configXML;	
				if(_configXML != null && _configXML.hasOwnProperty("smoke"))
				{
					_engineSmoke = new Vector.<MovieClip>();
					_engineSmokePos = new Vector.<Point>();
					_effectReady = true;
				}
			}
			else
			{
				throw new IllegalOperationError("RocketEngineRender must use in EffectRocketComponent");
			}
		}
	}
}