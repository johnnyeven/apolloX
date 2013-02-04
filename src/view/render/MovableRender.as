package view.render
{
	import enum.EnumAction;
	
	import flash.errors.IllegalOperationError;
	import flash.geom.Point;
	
	import mediator.space.SpaceBackgroundMediator;
	
	import utils.configuration.GlobalContextConfig;
	import utils.configuration.MapContextConfig;
	import utils.liteui.core.Component;
	
	import view.space.MovableComponent;
	import view.space.background.SpaceBackgroundComponent;

	public class MovableRender extends Render
	{
		protected var _backgroundComponent: SpaceBackgroundComponent;
		protected var _preDirection: int;
		
		public function MainRender()
		{
			super();
			var _mediator: SpaceBackgroundMediator = ApplicationFacade.getInstance().retrieveMediator(SpaceBackgroundMediator.NAME) as SpaceBackgroundMediator;
			_backgroundComponent = _mediator.component;
		}
		
		override public function rendering(force:Boolean=false):void
		{
			if(_target is MovableComponent)
			{
				var _targetComponent: MovableComponent = _target as MovableComponent;
				if(!force && _targetComponent.staticUpdate && (_targetComponent.action == EnumAction.STOP || _targetComponent.action == EnumAction.SIT))
				{
					return;
				}
				var targetX: Number = 0;
				var targetY: Number = 0;
				
				var maxX: uint = MapContextConfig.MapSize.x;
				var maxY: uint = MapContextConfig.MapSize.y;
				
				if(_targetComponent.focused)
				{
					targetX = _targetComponent.posX < GlobalContextConfig.Width / 2 ? _targetComponent.posX : GlobalContextConfig.Width / 2;
					targetY = _targetComponent.posY < GlobalContextConfig.Height / 2 ? _targetComponent.posY : GlobalContextConfig.Height / 2;
					
					targetX = _targetComponent.posX > (maxX - GlobalContextConfig.Width / 2) ? _targetComponent.posX - (maxX - GlobalContextConfig.Width) : targetX;
					targetY = _targetComponent.posY > (maxY - GlobalContextConfig.Height / 2) ? _targetComponent.posY - (maxY - GlobalContextConfig.Height) : targetY;
				}
				else
				{
					var _pos: Point = _backgroundComponent.getScreenPosition(new Point(_targetComponent.posX, _targetComponent.posY));
					targetX = _pos.x;
					targetY = _pos.y;
				}
				
				_targetComponent.x = targetX;
				_targetComponent.y = targetY;
				
				_targetComponent.staticUpdate = true;
				
				super.rendering(force);
				draw(_targetComponent.direction);
			}
			else
			{
				throw new IllegalOperationError("MovableRender must use in a MovableComponent");
			}
		}
		
		override public function set target(value:Component):void
		{
			if(value is MovableComponent)
			{
				super.target = value;
				_preDirection = (_target as MovableComponent).direction;
			}
			else
			{
				throw new IllegalOperationError("MovableRender must use in a MovableComponent");
			}
		}
		
		override protected function draw(_direction:int):void
		{
			if(_target is MovableComponent)
			{
				(_target as MovableComponent).graphic.gotoAndStop(_direction);
			}
		}
	}
}