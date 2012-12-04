package mediator.scene.station
{
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	
	import utils.enum.PopupEffect;
	
	import view.scene.station.ensure.EnsureSelectViewComponent;
	
	public class EnsureSelectViewMediator extends BaseMediator
	{
		public static const NAME: String = "EnsureSelectViewMediator";
		
		public static const ENSURE_SHOW_NOTE: String = "EnsureSelectViewMediator.ensureselect_show_note";
		public static const ENSURE_DISPOSE_NOTE: String = "EnsureSelectViewMediator.ensureselect_dispose_note";
		
		public function EnsureSelectViewMediator()
		{
			super(NAME, new EnsureSelectViewComponent());
			component.mediator = this;
			_isPopUp = true;
			mode = true;
			popUpEffect = PopupEffect.CENTER;
			onShow = onShowCallback;
		}
		
		public function get component(): EnsureSelectViewComponent
		{
			return viewComponent as EnsureSelectViewComponent;
		}
		
		override public function listNotificationInterests():Array
		{
			return [ENSURE_SHOW_NOTE, ENSURE_DISPOSE_NOTE];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ENSURE_SHOW_NOTE:
					show();
					break;
				case ENSURE_DISPOSE_NOTE:
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