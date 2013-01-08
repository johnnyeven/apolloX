package controller.login
{
	import controller.init.LoadServerListCommand;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class CreateServerMediatorCommand extends SimpleCommand
	{
		public static const NAME: String = "CreateServerMediatorCommand";
		public static const CREATE_NOTE: String = "CreateServerMediatorCommand.CreateNote";
		
		public function CreateServerMediatorCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			sendNotification(LoadServerListCommand.LOAD_SERVERLIST_NOTE);
		}
	}
}