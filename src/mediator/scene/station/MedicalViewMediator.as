package mediator.scene.station
{
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	
	import utils.enum.PopupEffect;
	
	import view.scene.station.medical.MedicalViewComponent;
	
	public class MedicalViewMediator extends BaseMediator
	{
		public static const NAME: String = "MedicalViewMediator";
		
		public static const MEDICAL_SHOW_NOTE: String = "MedicalViewMediator.medical_show_note";
		public static const MEDICAL_DISPOSE_NOTE: String = "MedicalViewMediator.medical_dispose_note";
		
		public function MedicalViewMediator()
		{
			super(NAME, new MedicalViewComponent());
			component.mediator = this;
			_isPopUp = true;
			popUpEffect = PopupEffect.CENTER;
			onShow = onShowCallback;
		}
		
		public function get component(): MedicalViewComponent
		{
			return viewComponent as MedicalViewComponent;
		}
		
		override public function listNotificationInterests():Array
		{
			return [MEDICAL_SHOW_NOTE, MEDICAL_DISPOSE_NOTE];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case MEDICAL_SHOW_NOTE:
					show();
					break;
				case MEDICAL_DISPOSE_NOTE:
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