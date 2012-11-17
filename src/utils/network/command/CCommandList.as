package utils.network.command 
{
	import flash.errors.IllegalOperationError;
	
	/**
	 * ...
	 * @author john
	 */
	public class CCommandList extends CCommandContainer 
	{
		private static var instance: CCommandList;
		private static var allowInstance: Boolean = false;
		
		public function CCommandList() 
		{
			super();
			if (!allowInstance)
			{
				throw new IllegalOperationError("CCommandList不允许实例化");
			}
		}
		
		public function bind(flag: uint, protocol: Class): void
		{
			if (commandList[flag] == null)
			{
				commandList[flag] = protocol;
			}
		}
		
		public function unbind(flag: uint, protocol: Class): void
		{
			if (commandList[flag] != null)
			{
				commandList[flag] = null;
				delete commandList[flag];
			}
		}
		
		public static function getInstance(): CCommandList
		{
			if (instance == null)
			{
				allowInstance = true;
				instance = new CCommandList();
				allowInstance = false;
			}
			return instance;
		}
	}

}