package utils.loader 
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Johnny.EVE
	 */
	public class URLSmartLoader extends URLLoader 
	{
		public var isLoading: Boolean = false;
		
		public function URLSmartLoader(request:URLRequest=null) 
		{
			super(request);
			
		}
		
	}

}