package mediator.scene.station
{
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	
	import utils.enum.PopupEffect;
	
	import view.scene.station.repair.RepairViewComponent;
	
	public class RepairViewMediator extends BaseMediator
	{
		public static const NAME: String = "RepairViewMediator";
		
		public static const REPAIR_SHOW_NOTE: String = "RepairViewMediator.repair_show_note";
		public static const REPAIR_DISPOSE_NOTE: String = "RepairViewMediator.repair_dispose_note";
		
		public function RepairViewMediator()
		{
			super(NAME, new RepairViewComponent());
			component.mediator = this;
			_isPopUp = true;
			popUpEffect = PopupEffect.CENTER;
			onShow = onShowCallback;
		}
		
		public function get component(): RepairViewComponent
		{
			return viewComponent as RepairViewComponent;
		}
		
		override public function listNotificationInterests():Array
		{
			return [REPAIR_SHOW_NOTE, REPAIR_DISPOSE_NOTE];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case REPAIR_SHOW_NOTE:
					show();
					break;
				case REPAIR_DISPOSE_NOTE:
					dispose();
					break;
			}
		}
		
		override public function show():void
		{
			super.show();
		}
		
		private function onShowCallback(_mediator: BaseMediator): void
		{
			component.showListComponent();
		}
	}
}