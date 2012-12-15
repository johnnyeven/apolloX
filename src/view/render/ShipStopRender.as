package view.render
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import enum.EnumAction;
	
	import flash.errors.IllegalOperationError;
	
	import view.space.MovableComponent;
	
	public class ShipStopRender extends Render
	{
		private var _isMoving: Boolean = false;
		
		public function ShipStopRender()
		{
			super();
		}
		
		override public function rendering(force:Boolean=false):void
		{
			if(_target != null && _target is MovableComponent)
			{
				var _targetComponent: MovableComponent = _target as MovableComponent;
				if(_targetComponent.action == EnumAction.STOP && _targetComponent.graphic != null && !_isMoving)
				{
					_isMoving = true;
					TweenLite.to(_targetComponent.graphic, 2, {y: -10, ease: Linear.easeNone, onComplete: function(): void
					{
						TweenLite.to(_targetComponent.graphic, 2, {y: 0, ease: Linear.easeNone, onComplete: function(): void
						{
							_isMoving = false;
						}});
					}});
				}
			}
			else
			{
				throw new IllegalOperationError("ShipStopRender must use in a MovableComponent");
			}
		}
	}
}