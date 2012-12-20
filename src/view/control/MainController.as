package view.control
{
	import enum.EnumAction;
	import enum.EnumShipDirection;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mediator.space.SpaceBackgroundMediator;
	
	import utils.GameManager;
	import utils.configuration.GlobalContextConfig;
	
	import view.space.background.SpaceBackgroundComponent;
	import view.space.ship.ShipComponent;

	public class MainController extends BaseController
	{
		protected var _step: uint;
		protected var _path: Array;
		protected var _controlType: uint = MOUSE;
		protected var _key_w: Boolean;
		protected var _key_a: Boolean;
		protected var _key_s: Boolean;
		protected var _key_d: Boolean;
		protected var _lastAttackTime: int;
		protected var _listenerSetuped: Boolean = false;
		protected var _preSyncTimer: uint;
		protected var _currentKey: int;
		protected var _backgroundComponent: SpaceBackgroundComponent;
		
		public static const MOUSE: uint = 1;
		public static const KEY: uint = 2;
		public static const KEY_AND_MOUSE: uint = 0;
		
		public function MainController()
		{
			super();
			_step = 1;
			_key_w = false;
			_key_a = false;
			_key_s = false;
			_key_d = false;
			_lastAttackTime = 0;
			_preSyncTimer = GlobalContextConfig.Timer;
			var _mediator: SpaceBackgroundMediator = ApplicationFacade.getInstance().retrieveMediator(SpaceBackgroundMediator.NAME) as SpaceBackgroundMediator;
			_backgroundComponent = _mediator.component;
		}
		
		override public function setupListener():void
		{
			switch(_controlType)
			{
				case MOUSE:
					setupMouseListener();
					break;
				case KEY:
					
					break;
			}
			_listenerSetuped = true;
		}
		
		private function setupMouseListener(): void
		{
			GameManager.container.addEventListener(MouseEvent.CLICK, onMouseClick, false, 0, true);
		}
		
		protected function onMouseClick(evt: MouseEvent): void
		{
			if(!isStatic)
			{
				_target.action = EnumAction.STOP;
				
				_endPoint = _backgroundComponent.getMapPosition(new Point(evt.stageX, evt.stageY));
				
				if(_backgroundComponent.enableAstar)
				{
					var node: Array = SpaceBackgroundComponent.AStar.find(_target.posX, _target.posY, _endPoint.x, _endPoint.y);
					if(node == null)
					{
						return;
					}
					else
					{
						_path = new Array();
						for (var i: uint = 0; i < node.length; i++)
						{
							_path.push([node[i].x, node[i].y]);
						}
					}
					_endPoint = SpaceBackgroundComponent.blockToMapPosition(new Point(_path[_path.length - 1][0], _path[_path.length - 1][1]));
				}
				else
				{
					_path = new Array();
					_path.push([_target.posX, _target.posY]);
					_path.push([_endPoint.x, _endPoint.y]);
				}
				//CCommandCenter.commandMoveTo(_endPoint.x, _endPoint.y);
				_step = 1;
			}
		}
		
		override public function moveTo(_x: Number, _y: Number): void
		{
			_target.action = EnumAction.STOP;
			
			_endPoint = new Point(_x, _y);
			if(_backgroundComponent.enableAstar)
			{
				var node: Array = SpaceBackgroundComponent.AStar.find(_target.posX, _target.posY, _x, _y);
				if(node == null)
				{
					return;
				}
				else
				{
					_path = new Array();
					for (var i: uint = 0; i < node.length; i++)
					{
						_path.push([node[i].x, node[i].y]);
					}
				}
				_endPoint = SpaceBackgroundComponent.blockToMapPosition(new Point(_path[_path.length - 1][0], _path[_path.length - 1][1]));
			}
			else
			{
				_path = new Array();
				_path.push([_target.posX, _target.posY]);
				_path.push([_endPoint.x, _endPoint.y]);
			}
			//CCommandCenter.commandMoveTo(_endPoint.x, _endPoint.y);
			_step = 1;
		}
		
		protected function move(nextX: Number, nextY: Number): void
		{
			_target.setPos(nextX, nextY);
			
			if (_target.action != EnumAction.DIE)
			{
				_target.action = EnumAction.MOVE;
			}
		}
		
		override public function calculateAction():void
		{
			switch(_controlType)
			{
				case MOUSE:
					calculateActionMouse();
					break;
				case KEY:
					
					break;
			}
		}
		
		protected function calculateActionMouse(): void
		{
			if(!isStatic && _path != null && _path[_step] != null)
			{
				var target: ShipComponent = _target as ShipComponent;
				if(_backgroundComponent.enableAstar)
				{
					_nextPoint = _step == _path.length ? _endPoint : SpaceBackgroundComponent.blockToMapPosition(new Point(_path[_step][0], _path[_step][1]));
				}
				else
				{
					_nextPoint = _step == _path.length ? _endPoint : new Point(_path[_step][0], _path[_step][1]);
				}
				
				var degress: Number = EnumShipDirection.getDegress(_nextPoint.x - target.posX, _nextPoint.y - target.posY);
				var angle: Number = EnumShipDirection.degressToRadians(degress);
				
				var readyX: Boolean = false;
				var readyY: Boolean = false;
				
				var speedX: Number = target.info.speed * Math.cos(degress);
				var speedY: Number = target.info.speed * Math.sin(degress);
				
				if (Math.abs(target.posX - _nextPoint.x) <= speedX)
				{
					readyX = true;
					speedX = 0;
				}
				if (Math.abs(target.posY - _nextPoint.y) <= speedY)
				{
					readyY = true;
					speedY = 0;
				}
				
				move(target.posX + speedX, target.posY + speedY);
				
				if (readyX && readyY)
				{
					_step++;
					if (_step >= _path.length)
					{
						target.action = EnumAction.STOP;
						_path = null;
						_step = 1;
						//dispatchEvent(new ControllerEvent(ControllerEvent.MOVE_INTO_POSITION));
						//syncPosition(true);
					}
				}
				else
				{
					changeDirectionByAngle(angle);
				}
			}
		}
		
		protected function get isStatic(): Boolean
		{
			if (_target == null)
			{
				return true;
			}
			if (_target.action == EnumAction.DIE)
			{
				return true;
			}
			return false;
		}
		
		override public function clear():void
		{
			_path = null;
			_endPoint = null;
		}

		public function get backgroundComponent():SpaceBackgroundComponent
		{
			return _backgroundComponent;
		}

	}
}