package controller.init
{
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import mediator.loader.ProgressBarMediator;
	
	import utils.VersionUtils;
	import utils.events.LoaderEvent;
	import utils.language.LanguageManager;
	import utils.loader.ResourceLoadManager;
	import utils.loader.XMLLoader;
	
	public class LoadResourceConfigCommand extends SimpleCommand
	{
		public static const LOAD_CONFIG_NOTE: String = "LoaderResourceConfigCommand.LoadConfigNote";
		private var _xmlLoader: XMLLoader;
		
		public function LoadResourceConfigCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			facade.removeCommand(LOAD_CONFIG_NOTE);
			facade.registerMediator(new ProgressBarMediator());
			
			_xmlLoader = new XMLLoader("config/" + LanguageManager.language + "/resources.xml");
			_xmlLoader.version = VersionUtils.getVersion("resource_config");
			
			_xmlLoader.addEventListener(LoaderEvent.COMPLETE, onLoadComplete);
			_xmlLoader.addEventListener(LoaderEvent.PROGRESS, onLoadProgress);
			_xmlLoader.addEventListener(LoaderEvent.IO_ERROR, onLoadIOError);
			
			sendNotification(ResourceLoadManager.SET_PROGRESSBAR_TITLE_NOTE, LanguageManager.getInstance().lang("load_resource_config"));
			sendNotification(ResourceLoadManager.SHOW_PROGRESSBAR_NOTE);
			
			_xmlLoader.load();
		}
		
		private function removeListener(): void
		{
			_xmlLoader.removeEventListener(LoaderEvent.COMPLETE, onLoadComplete);
			_xmlLoader.removeEventListener(LoaderEvent.PROGRESS, onLoadProgress);
			_xmlLoader.removeEventListener(LoaderEvent.IO_ERROR, onLoadIOError);
		}
		
		private function loadPrepareResource(): void
		{
			ResourceLoadManager.load("prepareResource", true, LanguageManager.getInstance().lang("load_pre_resource"), function(evt: LoaderEvent) {
			
			});
		}
		
		protected function onLoadComplete(evt: LoaderEvent): void
		{
			sendNotification(ResourceLoadManager.HIDE_PROGRESSBAR_NOTE);
			removeListener();
			
			sendNotification(LoadResourcesCommand.LOAD_RESOURCES_NOTE);
		}
		
		protected function onLoadProgress(evt: LoaderEvent): void
		{
			var _percent: int = Math.floor(evt.bytesLoaded / evt.bytesTotal);
			sendNotification(ResourceLoadManager.SET_PROGRESSBAR_PERCENT_NOTE, _percent);
		}
		
		protected function onLoadIOError(evt: LoaderEvent): void
		{
			removeListener();
			sendNotification(ResourceLoadManager.HIDE_PROGRESSBAR_NOTE);
		}
	}
}