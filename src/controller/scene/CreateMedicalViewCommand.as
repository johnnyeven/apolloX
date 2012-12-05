package controller.scene
{
	import flash.display.DisplayObject;
	
	import mediator.scene.station.MedicalViewMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import utils.resource.ResourcePool;
	
	public class CreateMedicalViewCommand extends SimpleCommand
	{
		public static const LOAD_MEDICAL_VIEW_NOTE: String = "LoadMedicalViewNote";
		
		public function CreateMedicalViewCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var _mediator: MedicalViewMediator = facade.retrieveMediator(MedicalViewMediator.NAME) as MedicalViewMediator;
			if (_mediator != null)
			{
				facade.sendNotification(MedicalViewMediator.MEDICAL_SHOW_NOTE);
			}
			else
			{
				ResourcePool.getResourceByLoader("station_medical_ui", "assets.scene1Station.medical.view", onLoadComplete);
			}
		}
		
		private function onLoadComplete(target: DisplayObject): void
		{
			var _mediator: MedicalViewMediator = new MedicalViewMediator();
			facade.registerMediator(_mediator);
			
			facade.sendNotification(MedicalViewMediator.MEDICAL_SHOW_NOTE);
		}
	}
}