package controller.space
{
	import mediator.space.SpaceBackgroundMediator;
	import mediator.space.SpaceSceneMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import parameters.space.LeaveIntoSpaceParameter;
	
	import proxy.SceneProxy;
	
	public class CreateSpaceSceneCommand extends SimpleCommand
	{
		public static const CREATE_SPACE_SCENE_NOTE: String = "CreateSpaceSceneNote";
		
		public function CreateSpaceSceneCommand()
		{
			super();
			
			initNotifier();
		}
		
		override public function execute(notification:INotification):void
		{
			if(!facade.hasMediator(SpaceSceneMediator.NAME))
			{
				facade.registerMediator(new SpaceSceneMediator());
			}
			facade.sendNotification(SpaceSceneMediator.CREATE_BACKGROUND_NOTE);
		}
		
		private function initNotifier(): void
		{
			facade.registerProxy(new SceneProxy());
		}
	}
}