package utils.events
{
	import flash.events.IOErrorEvent;
	
	public class MapIOErrorEvent extends IOErrorEvent
	{
		public static const VERIFY_ERROR: String = "MapIOErrorEvent.VerifyError";
		
		public function MapIOErrorEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, text:String="", id:int=0)
		{
			super(type, bubbles, cancelable, text, id);
		}
	}
}