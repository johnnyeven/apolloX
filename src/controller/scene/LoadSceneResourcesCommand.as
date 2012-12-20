package controller.scene
{
	import controller.init.LoadServerListCommand;
	import controller.space.CreateMainShipCommand;
	import controller.space.CreateStationCommand;
	import controller.space.CreateSpaceBackgroundCommand;
	
	import mediator.loader.ProgressBarMediator;
	import mediator.login.StartMediator;
	import mediator.scene.SceneBackgroundMediator;
	import mediator.scene.SceneControlMediator;
	import mediator.scene.station.StationViewMediator;
	
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
			facade.registerMediator(new SceneBackgroundMediator());
			facade.registerMediator(new StationViewMediator());
			facade.registerCommand(CreateSpaceBackgroundCommand.CREATE_SPACE_BACKGROUND_NOTE, CreateSpaceBackgroundCommand);
			facade.registerCommand(CreateMainShipCommand.CREATE_MAIN_SHIP_NOTE, CreateMainShipCommand);
			facade.registerCommand(CreateStationCommand.CREATE_STATION_NOTE, CreateStationCommand);
			facade.registerCommand(CreateAssemblyViewCommand.LOAD_ASSEMBLY_VIEW_NOTE, CreateAssemblyViewCommand);
			facade.registerCommand(CreateMarketViewCommand.LOAD_MARKET_VIEW_NOTE, CreateMarketViewCommand);
			facade.registerCommand(CreateRepairViewCommand.LOAD_REPAIR_VIEW_NOTE, CreateRepairViewCommand);
			facade.registerCommand(CreateRepairViewCommand.LOAD_REPAIR_VIEW_NOTE, CreateRepairViewCommand);
			facade.registerCommand(CreateMedicalViewCommand.LOAD_MEDICAL_VIEW_NOTE, CreateMedicalViewCommand);
			facade.registerCommand(CreateEnsureViewCommand.LOAD_ENSURE_VIEW_NOTE, CreateEnsureViewCommand);
			facade.registerCommand(CreateEnsureSelectViewCommand.LOAD_ENSURE_VIEW_NOTE, CreateEnsureSelectViewCommand);
			
//			var _backgroundMediator: SceneBackgroundMediator = facade.retrieveMediator(SceneBackgroundMediator.NAME) as SceneBackgroundMediator;
//			_backgroundMediator.show();
//			
//			var _controlMediator: SceneControlMediator = new SceneControlMediator();
//			facade.registerMediator(_controlMediator);
//			_controlMediator.show();
			
			var _stationMediator: StationViewMediator = facade.retrieveMediator(StationViewMediator.NAME) as StationViewMediator;
			facade.sendNotification(StationViewMediator.STATION_SHOW_NOTE);
			
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