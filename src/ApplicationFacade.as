package
{
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;
	
	import controller.ApplicationCommand;
	
	public class ApplicationFacade extends Facade
	{
		public static const START_APP: String = "ApplicationFacade.StartAppNote";
		
		public function ApplicationFacade()
		{
			super();
		}
		
		public static function getInstance(): ApplicationFacade
		{
			if(instance == null)
			{
				instance = new ApplicationFacade();
			}
			return instance as ApplicationFacade;
		}
		
		override protected function initializeController():void
		{
			super.initializeController();
			registerCommand(START_APP, ApplicationCommand);
		}
		
		public function start(app: Main): void
		{
			sendNotification(START_APP, app);
		}
	}
}