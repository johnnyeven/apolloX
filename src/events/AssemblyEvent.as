package events
{
	import flash.events.Event;
	
	public class AssemblyEvent extends Event
	{
		public static const SHOW_SLOTS: String = "AssemblyEvent.ShowSlots";
		
		public function AssemblyEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}