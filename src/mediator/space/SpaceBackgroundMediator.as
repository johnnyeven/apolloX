package mediator.space
{
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import utils.StringUtils;
	
	import view.space.background.SpaceBackgroundComponent;
	
	public class SpaceBackgroundMediator extends Mediator implements IMediator
	{
		public static const NAME: String = "SpaceBackgroundMediator";
		public static const SHOW_MAP_NOTE: String = "SpaceBackgroundMediator.ShowMapNote";
		
		public function SpaceBackgroundMediator()
		{
			super(NAME, new SpaceBackgroundComponent);
		}
		
		public function get component(): SpaceBackgroundComponent
		{
			return viewComponent as SpaceBackgroundComponent;
		}
		
		override public function listNotificationInterests():Array
		{
			return [SHOW_MAP_NOTE];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case SHOW_MAP_NOTE:
					var id: String = String(notification.getBody());
					if(!StringUtils.empty(id))
					{
						component.id = id;
					}
					break;
			}
		}
	}
}