package mediator.scene.station
{
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	
	import utils.enum.PopupEffect;
	
	import view.scene.station.ensure.EnsureViewComponent;
	
	public class EnsureViewMediator extends BaseMediator
	{
		public static const NAME: String = "EnsureViewMediator";
		
		public static const ENSURE_SHOW_NOTE: String = "EnsureViewMediator.ensure_show_note";
		public static const ENSURE_DISPOSE_NOTE: String = "EnsureViewMediator.ensure_dispose_note";
		
		public function EnsureViewMediator()
		{
			super(NAME, new EnsureViewComponent());
			component.mediator = this;
			_isPopUp = true;
			popUpEffect = PopupEffect.CENTER;
			onShow = onShowCallback;
		}
		
		public function get component(): EnsureViewComponent
		{
			return viewComponent as EnsureViewComponent;
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