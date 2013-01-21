package controller.login
{
	import mediator.login.StartMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class CreateStartMediatorCommand extends SimpleCommand
	{
		public static const CREATE_LOGIN_VIEW_NOTE: String = "CreateLoginViewCommand";
		
		public function CreateStartMediatorCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			facade.removeCommand(CREATE_LOGIN_VIEW_NOTE);
			
			facade.registerMediator(new StartMediator());
			facade.sendNotification(StartMediator.SHOW_NOTE);
		}
	}
}