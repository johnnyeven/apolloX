package controller.space
{
	import mediator.space.SpaceMainShipMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import parameters.ship.ShipParameter;
	import parameters.space.LeaveIntoSpaceParameter;
	
	public class CreateMainShipCommand extends SimpleCommand
	{
		public static const CREATE_MAIN_SHIP_NOTE: String = "CreateMainShipNote";
		
		public function CreateMainShipCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			if(!facade.hasMediator(SpaceMainShipMediator.NAME))
			{
				facade.registerMediator(new SpaceMainShipMediator());
			}
			
			var parameter: ShipParameter = new ShipParameter();
			parameter.id = 123435;
			parameter.speed = 10;
			parameter.x = 550;
			parameter.y = 200;
			parameter.shipResource = 1;
			
			facade.sendNotification(SpaceMainShipMediator.SHOW_NOTE, parameter);
		}
	}
}