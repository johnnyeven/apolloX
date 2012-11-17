package utils.events
{
	import flash.events.Event;
	
	public class ScrollBarEvent extends Event
	{
		public static const RESIZE: String = "ScrollBarEvent.Resize";
		
		public function ScrollBarEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}