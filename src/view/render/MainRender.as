package view.render
{
	import enum.EnumAction;
	
	import flash.errors.IllegalOperationError;
	
	import utils.configuration.GlobalContextConfig;
	import utils.configuration.MapContextConfig;
	
	import view.control.MainController;
	import view.space.MovableComponent;

	public class MainRender extends Render
	{
		public function MainRender()
		{
			super();
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
					targetX = _targetComponent.posX;
					targetY = _targetComponent.posY;
				}
				
				_targetComponent.x = targetX;
				_targetComponent.y = targetY;
				
				_targetComponent.staticUpdate = true;
				
				super.rendering(force);
				draw(_targetComponent.direction);
			}
			else
			{
				throw new IllegalOperationError("MainRender must use in a SpaceComponent");
			}
		}
	}
}