package controller.scene
{
	import flash.display.DisplayObject;
	
	import mediator.scene.station.RepairViewMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import utils.resource.ResourcePool;
	
	public class CreateRepairViewCommand extends SimpleCommand
	{
		public static const LOAD_REPAIR_VIEW_NOTE: String = "LoadRepairViewNote";
		
		public function CreateRepairViewCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var _mediator: RepairViewMediator = facade.retrieveMediator(RepairViewMediator.NAME) as RepairViewMediator;
			if (_mediator != null)
			{
				facade.sendNotification(RepairViewMediator.REPAIR_SHOW_NOTE);
			}
			else
			{
				ResourcePool.getResourceByLoader("station_repair_ui", "assets.scene1Station.repair.view", onLoadComplete);
			}
		}
		
		private function onLoadComplete(target: DisplayObject): void
		{
			var _mediator: RepairViewMediator = new RepairViewMediator();
			facade.registerMediator(_mediator);
			
			facade.sendNotification(RepairViewMediator.REPAIR_SHOW_NOTE);
		}
	}
}