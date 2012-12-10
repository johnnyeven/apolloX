package controller.space
{
	import mediator.space.SpaceBackgroundMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import parameters.space.LeaveIntoSpaceParameter;
	
	public class LeaveIntoSpaceCommand extends SimpleCommand
	{
		public static const LEAVE_INTO_SPACE_NOTE: String = "LeaseIntoSpaceNote";
		
		public function LeaveIntoSpaceCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			if(!facade.hasMediator(SpaceBackgroundMediator.NAME))
			{
				facade.registerMediator(new SpaceBackgroundMediator());
			}
			var parameter: LeaveIntoSpaceParameter = new LeaveIntoSpaceParameter();
			parameter.id = "10001";
			parameter.startX = 0;
			parameter.startY = 0;
			facade.sendNotification(SpaceBackgroundMediator.SHOW_MAP_NOTE, parameter);
		}
	}
}