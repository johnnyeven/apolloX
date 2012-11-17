package events
{
	import flash.events.Event;
	
	public class LoginEvent extends Event
	{
		public static const START_EVENT: String = "LoginEvent.startEvent";
		public static const ACCOUNT_EVENT: String = "LoginEvent.accountEvent";
		
		public function LoginEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}