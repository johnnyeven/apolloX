package view.control
{
	import com.greensock.TweenLite;
	
	import enum.EnumAction;
	import enum.EnumShipDirection;
	
	import flash.geom.Point;
	
	import mediator.space.SpaceBackgroundMediator;
	import mediator.space.effects.EffectRocketMediator;
	
	import utils.configuration.GlobalContextConfig;
	
	import view.space.MovableComponent;
	import view.space.StaticComponent;
	import view.space.background.SpaceBackgroundComponent;
	import view.space.ship.ShipComponent;

	public class ShipController extends BaseController
	{
		private var _ship: ShipComponent;
		private var _followObject: StaticComponent;
		protected var _backgroundComponent: SpaceBackgroundComponent;
		
		public function RocketController()
		{
			super();
			var _mediator: SpaceBackgroundMediator = ApplicationFacade.getInstance().retrieveMediator(SpaceBackgroundMediator.NAME) as SpaceBackgroundMediator;
			_backgroundComponent = _mediator.component;
			_nextPoint = new Point();
		}
		
		override public function calculateAction():void
		{
			if(_ship.action != EnumAction.STOP && _ship.action != EnumAction.EXPLODE)
			{
				if(_followObject != null)
				{
					_nextPoint.x = _followObject.posX;
					_nextPoint.y = _followObject.posY;
				}
				else
				{
					_nextPoint = _endPoint;
				}
				
				var degress: Number = EnumShipDirection.getDegress(_nextPoint.x - _ship.posX, _nextPoint.y - _ship.posY);
				var angle: Number = EnumShipDirection.degressToRadians(degress);
				
				var readyX: Boolean = false;
				var readyY: Boolean = false;
				
				var speedX: Number = _ship.info.speed * Math.cos(degress);
				var speedY: Number = _ship.info.speed * Math.sin(degress);
				
				if (Math.abs(_ship.posX - _nextPoint.x) <= speedX)
				{
					readyX = true;
					speedX = 0;
				}
				if (Math.abs(_ship.posY - _nextPoint.y) <= speedY)
				{
					readyY = true;
					speedY = 0;
				}
				
				move(_ship.posX + speedX, _ship.posY + speedY);
				
				if (readyX && readyY)
				{
					_ship.action = EnumAction.STOP;
				}
				else
				{
					changeDirectionByAngle(angle);
				}
			}
		}
		
		protected function move(nextX: Number, nextY: Number): void
		{
			_ship.setPos(nextX, nextY);
			
			if (_ship.action != EnumAction.DIE)
			{
				_ship.action = EnumAction.MOVE;
			}
		}
		
		override public function set target(value:MovableComponent):void
		{
			super.target = value;
			_ship = value as ShipComponent;
		}
	}
}