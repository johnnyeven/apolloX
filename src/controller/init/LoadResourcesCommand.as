package controller.init
{
	import controller.scene.LoadSceneResourcesCommand;
	
	import mediator.loader.ProgressBarMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import utils.language.LanguageManager;
	import utils.loader.ResourceLoadManager;
	import utils.events.LoaderEvent;
	
	public class LoadResourcesCommand extends SimpleCommand
	{
		public static const LOAD_RESOURCES_NOTE: String = "LoadResourcesCommand";
		
		public function LoadResourcesCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			facade.removeCommand(LOAD_RESOURCES_NOTE);
			facade.sendNotification(ProgressBarMediator.SHOW_RANDOM_BG);
			ResourceLoadManager.load("loginResources", true, LanguageManager.getInstance().lang("load_loagin_ui"), onLoadComplete, onLoadProgress, onLoadIOError);
		}
		
		private function onLoadComplete(evt: LoaderEvent): void
		{
			//facade.sendNotification(InitLoginServerCommand.LOAD_SERVER_NOTE);
			facade.sendNotification(LoadSceneResourcesCommand.LOAD_RESOURCES_NOTE);
		}
		
		private function onLoadProgress(evt: LoaderEvent): void
		{
			facade.sendNotification(ProgressBarMediator.SET_PROGRESSBAR_PERCENT_NOTE, Math.floor(evt.bytesLoaded / evt.bytesTotal));
		}
		
		private function onLoadIOError(evt: LoaderEvent): void
		{
			
		}
	}
}