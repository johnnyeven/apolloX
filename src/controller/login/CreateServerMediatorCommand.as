package controller.login
{
	import flash.display.DisplayObject;
	
	import mediator.login.ServerMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import utils.resource.ResourcePool;
	
	public class CreateServerMediatorCommand extends SimpleCommand
	{
		public static const CREATE_NOTE: String = "CreateServerMediatorCommand.CreateNote";
		
		public function CreateServerMediatorCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			facade.removeCommand(CreateServerMediatorCommand.CREATE_NOTE);
			
			var _mediator: ServerMediator = facade.retrieveMediator(ServerMediator.NAME) as ServerMediator;
			if (_mediator != null)
			{
				facade.sendNotification(ServerMediator.SHOW_NOTE);
			}
			else
			{
				ResourcePool.getResourceByLoader("server_ui", "ui.login.ServerWindowSkin", onLoadComplete);
			}
		}
		
		private function onLoadComplete(target: DisplayObject): void
		{
			facade.registerMediator(new ServerMediator());
			
			facade.sendNotification(ServerMediator.SHOW_NOTE);
		}
	}
}