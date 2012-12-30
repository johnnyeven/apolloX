package view.control
{
	import com.greensock.TweenLite;
	
	import enum.EnumAction;
	import enum.EnumShipDirection;
	
	import flash.geom.Point;
	
	import mediator.space.SpaceBackgroundMediator;
	
	import utils.configuration.GlobalContextConfig;
	
	import view.space.MovableComponent;
	import view.space.background.SpaceBackgroundComponent;
	import view.space.effects.rocket.EffectRocketComponent;

	public class RocketController extends BaseController
	{
		private var _rocket: EffectRocketComponent;
		protected var _preSyncTimer: uint;
		protected var _backgroundComponent: SpaceBackgroundComponent;
		
		public function RocketController()
		{
			super();
			_preSyncTimer = GlobalContextConfig.Timer;
			var _mediator: SpaceBackgroundMediator = ApplicationFacade.getInstance().retrieveMediator(SpaceBackgroundMediator.NAME) as SpaceBackgroundMediator;
			_backgroundComponent = _mediator.component;
		}
		
		override public function calculateAction():void
		{
			_nextPoint = _endPoint;
			
			var degress: Number = EnumShipDirection.getDegress(_nextPoint.x - _rocket.posX, _nextPoint.y - _rocket.posY);
			var angle: Number = EnumShipDirection.degressToRadians(degress);
			
			var readyX: Boolean = false;
			var readyY: Boolean = false;
			
			var speedX: Number = _rocket.currentSpeed * Math.cos(degress);
			var speedY: Number = _rocket.currentSpeed * Math.sin(degress);
			
			_rocket.currentSpeed += _rocket.info.acceleration;
			
			if (Math.abs(_rocket.posX - _nextPoint.x) <= speedX)
			{
				readyX = true;
				speedX = 0;
			}
			if (Math.abs(_rocket.posY - _nextPoint.y) <= speedY)
			{
				readyY = true;
				speedY = 0;
			}
			
			move(_rocket.posX + speedX, _rocket.posY + speedY);
			
			if (readyX && readyY)
			{
				_rocket.action = EnumAction.STOP;
			}
			else
			{
				changeDirectionByAngle(angle);
			}
		}
		
		protected function move(nextX: Number, nextY: Number): void
		{
			_rocket.setPos(nextX, nextY);
			
			if (_rocket.action != EnumAction.DIE)
			{
				_rocket.action = EnumAction.MOVE;
			}
		}
		
		override public function set target(value:MovableComponent):void
		{
			super.target = value;
			_rocket = value as EffectRocketComponent;
			_endPoint = _rocket.info.targetPos as Point;
		}
		
		override protected function changeDirectionByAngle(_angle:int): void
		{
			_rocket.direction = _angle + 180;
//			if (_angle != _preDirection)
//			{
//				TweenLite.to(_target, .3, {direction: _angle});
//				_preDirection = _angle;
//			}
		}
	}
}