package controller.space
{
	import mediator.space.SpaceBackgroundMediator;
	import mediator.space.SpaceSceneMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import parameters.space.LeaveIntoSpaceParameter;
	
	public class CreateSpaceSceneCommand extends SimpleCommand
	{
		public static const CREATE_SPACE_SCENE_NOTE: String = "CreateSpaceSceneNote";
		
		public function CreateSpaceSceneCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			if(!facade.hasMediator(SpaceSceneMediator.NAME))
			{
				facade.registerMediator(new SpaceSceneMediator());
			}
			sendNotification(SpaceSceneMediator.CREATE_BACKGROUND_NOTE);
		}
	}
}