package mediator.scene.station
{
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	
	import view.scene.station.assembly.AssemblyViewComponent;
	
	public class AssemblyViewMediator extends BaseMediator
	{
		public static const NAME: String = "AssemblyViewMediator";
		
		public static const ASSEMBLY_SHOW_NOTE: String = "AssemblyViewMediator.assembly_show_note";
		
		public function AssemblyViewMediator()
		{
			super(NAME, new AssemblyViewComponent());
		}
		
		public function get component(): AssemblyViewComponent
		{
			return viewComponent as AssemblyViewComponent;
		}
		
		override public function listNotificationInterests():Array
		{
			return [ASSEMBLY_SHOW_NOTE];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ASSEMBLY_SHOW_NOTE:
					show();
					break;
			}
		}
	}
}