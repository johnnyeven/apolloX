package view.render
{
	import enum.EnumAction;
	
	import utils.configuration.GlobalContextConfig;
	import utils.configuration.MapContextConfig;
	
	import view.control.MainController;

	public class MainRender extends Render
	{
		public function MainRender()
		{
			super();
		}
		
		override public function rendering(force:Boolean=false):void
		{
			if(!force && _target.staticUpdate && (_target.action == EnumAction.STOP || _target.action == EnumAction.SIT))
			{
				return;
			}
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
				targetX = _target.posX;
				targetY = _target.posY;
			}
			
			_target.x = targetX;
			_target.y = targetY;
			
			_target.staticUpdate = true;
			
			super.rendering(force);
			draw(_target.direction);
		}
	}
}