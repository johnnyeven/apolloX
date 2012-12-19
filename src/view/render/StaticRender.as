package view.render
{
	import enum.EnumAction;
	
	import flash.errors.IllegalOperationError;
	import flash.geom.Point;
	
	import mediator.space.SpaceBackgroundMediator;
	
	import utils.configuration.GlobalContextConfig;
	import utils.configuration.MapContextConfig;
	
	import view.control.MainController;
	import view.space.MovableComponent;
	import view.space.background.SpaceBackgroundComponent;

	public class StaticRender extends Render
	{
		protected var _backgroundComponent: SpaceBackgroundComponent;
		protected var _isRendering: Boolean = false;
		
		public function StaticRender()
		{
			super();
			var _mediator: SpaceBackgroundMediator = ApplicationFacade.getInstance().retrieveMediator(SpaceBackgroundMediator.NAME) as SpaceBackgroundMediator;
			_backgroundComponent = _mediator.component;
		}
		
		override public function rendering(force:Boolean=false):void
		{
			if(_target is MovableComponent)
			{
				throw new IllegalOperationError("StaticRender must use in a StaticComponent");
			}
			else
			{
//				if(!force && _isRendering)
//				{
//					return;
//				}
				var targetX: Number = 0;
				var targetY: Number = 0;
				
				var maxX: uint = MapContextConfig.MapSize.x;
				var maxY: uint = MapContextConfig.MapSize.y;
				
				if(_target.focused)
				{
					targetX = _target.posX < GlobalContextConfig.Width / 2 ? _target.posX : GlobalContextConfig.Width / 2;
					targetY = _target.posY < GlobalContextConfig.Height / 2 ? _target.posY : GlobalContextConfig.Height / 2;
					
					targetX = _target.posX > (maxX - GlobalContextConfig.Width / 2) ? _target.posX - (maxX - GlobalContextConfig.Width) : targetX;
					targetY = _target.posY > (maxY - GlobalContextConfig.Height / 2) ? _target.posY - (maxY - GlobalContextConfig.Height) : targetY;
				}
				else
				{
					var _pos: Point = _backgroundComponent.getScreenPosition(new Point(_target.posX, _target.posY));
					targetX = _pos.x;
					targetY = _pos.y;
				}
				
				_target.x = targetX;
				_target.y = targetY;
				
				_target.staticUpdate = true;
				
				super.rendering(force);
				
				if(!_isRendering)
				{
					draw(1);
				}
			}
		}
	}
}