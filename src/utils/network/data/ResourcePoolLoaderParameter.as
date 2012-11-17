package utils.network.data
{
	import flash.display.DisplayObjectContainer;

	public class ResourcePoolLoaderParameter
	{
		public var url: String = "";
		public var className: String = "";
		public var displayObject: DisplayObjectContainer;
		public var callback: Function;
		
		public function ResourcePoolLoaderParameter()
		{
		}
	}
}