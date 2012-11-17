package controller.scene
{
	import controller.init.LoadServerListCommand;
	
	import mediator.loader.ProgressBarMediator;
	import mediator.login.StartMediator;
	import mediator.scene.Scene1BackgroundMediator;
	import mediator.scene.SceneControlMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import utils.events.LoaderEvent;
	import utils.language.LanguageManager;
	import utils.loader.ResourceLoadManager;
	
	public class LoadSceneResourcesCommand extends SimpleCommand
	{
		public static const LOAD_RESOURCES_NOTE: String = "LoadSceneResourcesCommand";
		
		public function LoadSceneResourcesCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			facade.removeCommand(LOAD_RESOURCES_NOTE);
			
			sendNotification(ProgressBarMediator.SHOW_RANDOM_BG);
			ResourceLoadManager.load("necessaryResources", true, LanguageManager.getInstance().lang("load_scene_ui"), onLoadComplete, onLoadProgress, onLoadIOError);
		}
		
		private function onLoadComplete(evt: LoaderEvent): void
		{
			facade.registerMediator(new Scene1BackgroundMediator());
			
//			var _backgroundMediator: Scene1BackgroundMediator = facade.retrieveMediator(Scene1BackgroundMediator.NAME) as Scene1BackgroundMediator;
//			_backgroundMediator.show();
//			
//			var _controlMediator: SceneControlMediator = new SceneControlMediator();
//			facade.registerMediator(_controlMediator);
//			_controlMediator.show();
			
			sendNotification(ProgressBarMediator.HIDE_RANDOM_BG);
		}
		
		private function onLoadProgress(evt: LoaderEvent): void
		{
			sendNotification(ProgressBarMediator.SET_PROGRESSBAR_PERCENT_NOTE, evt.bytesLoaded / evt.bytesTotal);
		}
		
		private function onLoadIOError(evt: LoaderEvent): void
		{
			
		}
	}
}