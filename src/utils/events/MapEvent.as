package utils.events
{
	import flash.events.Event;
	
	public class MapEvent extends Event
	{
		public static const MAP_READY: String = "MapEvent.MapReady";
		
		public function MapEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}