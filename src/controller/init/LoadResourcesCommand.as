package controller.init
{
	import controller.init.LoadServerListCommand;
	
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
			
			sendNotification(ProgressBarMediator.SHOW_RANDOM_BG);
			/*
			var _loader: Loader = new Loader();
			var _urlRequest: URLRequest = new URLRequest("resources/ui/login/login_ui.swf");
			var _loaderContext: LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoadProgress);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadIOError);
			_loader.load(_urlRequest, _loaderContext);
			*/
			ResourceLoadManager.load("login_ui", true, LanguageManager.getInstance().lang("load_loagin_ui"), onLoadComplete, onLoadProgress, onLoadIOError);
			
//			sendNotification(ProgressBarMediator.SHOW_RANDOM_BG);
//			sendNotification(ProgressBarMediator.SHOW_PROGRESSBAR_NOTE);
//			sendNotification(ProgressBarMediator.SET_PROGRESSBAR_TITLE_NOTE, LanguageManager.getInstance().lang("load_loagin_ui"));
		}
		
		private function onLoadComplete(evt: LoaderEvent): void
		{
			//sendNotification(ProgressBarMediator.HIDE_PROGRESSBAR_NOTE);
			sendNotification(LoadServerListCommand.LOAD_SERVERLIST_NOTE);
		}
		
		private function onLoadProgress(evt: LoaderEvent): void
		{
			sendNotification(ProgressBarMediator.SET_PROGRESSBAR_PERCENT_NOTE, Math.floor(evt.bytesLoaded / evt.bytesTotal));
		}
		
		private function onLoadIOError(evt: LoaderEvent): void
		{
			
		}
	}
}