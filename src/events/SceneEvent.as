package events
{
	import flash.display.InteractiveObject;
	import flash.events.MouseEvent;
	
	public class SceneEvent extends MouseEvent
	{
		public static const TRITIUM_GROUND_CLICK: String = "tritium_ground_click";
		public static const BASE_GROUND_CLICK: String = "base_ground_click";
		public static const TIMEMACHINE_GROUND_CLICK: String = "timemachine_ground_click";
		public static const POWER_GROUND_CLICK: String = "power_ground_click";
		public static const PACKAGE_GROUND_CLICK: String = "package_ground_click";
		public static const CRYSTAL_GROUND_CLICK: String = "crystal_ground_click";
		public static const SCIENCE_GROUND_CLICK: String = "science_ground_click";
		public static const FACTORY_GROUND_CLICK: String = "factory_ground_click";
		
		public function SceneEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false, localX:Number=0, localY:Number=0, relatedObject:InteractiveObject=null, ctrlKey:Boolean=false, altKey:Boolean=false, shiftKey:Boolean=false, buttonDown:Boolean=false, delta:int=0)
		{
			super(type, bubbles, cancelable, localX, localY, relatedObject, ctrlKey, altKey, shiftKey, buttonDown, delta);
		}
	}
}