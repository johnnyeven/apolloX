package controller.space
{
	import enum.EnumShipDirection;
	
	import mediator.space.SpaceStationMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import parameters.space.LeaveIntoSpaceParameter;
	import parameters.space.SpaceStationParameter;
	
	public class CreateStationCommand extends SimpleCommand
	{
		public static const CREATE_STATION_NOTE: String = "CreateStationNote";
		
		public function CreateStationCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			if(!facade.hasMediator(SpaceStationMediator.NAME))
			{
				facade.registerMediator(new SpaceStationMediator());
			}
			
			var parameter: SpaceStationParameter = new SpaceStationParameter();
			parameter.id = 123435;
			parameter.stationResource = 2;
			parameter.x = 1100;
			parameter.y = 2000;
			
			facade.sendNotification(SpaceStationMediator.SHOW_NOTE, parameter);
		}
	}
}