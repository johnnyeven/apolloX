package utils.network 
{
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author john
	 */
	public class CBaseCenter extends EventDispatcher 
	{
		private var callbackList: Dictionary;
		
		public function CBaseCenter() 
		{
			super(this);
			callbackList = new Dictionary();
		}
		
		protected function addCallback(key: Object, processor: Function): void
		{
			var processorList: Array = callbackList[key] as Array;
			if (processorList == null)
			{
				processorList = new Array();
				callbackList[key] = processorList;
			}
			processorList.push(processor);
		}
		
		protected function removeCallback(key: Object, processor: Function): void
		{
			var processorList: Array = callbackList[key] as Array;
			if (processorList != null)
			{
				var index: int = processorList.indexOf(processor);
				if (index > -1)
				{
					processorList.slice(index, 1);
				}
				if (processorList.length == 0)
				{
					callbackList[key] = null;
					delete callbackList[key];
				}
			}
		}
		
		protected function triggerCallback(key: Object, data: Object): void
		{
			var processorList: Array = getCallbackList(key);
			if (processorList != null)
			{
				for each(var processor: Function in processorList)
				{
					processor(data);
				}
			}
		}
		
		protected function getCallbackList(key: Object): Array
		{
			return callbackList[key] as Array;
		}
	}

}