package utils.network.command.receiving 
{
	import utils.network.command.interfaces.INetPackageReceiving;
	import utils.network.command.CCommandBase;
	
	/**
	 * ...
	 * @author john
	 */
	public class CNetPackageReceiving extends CCommandBase implements INetPackageReceiving 
	{
		public var message: int;
		
		public function CNetPackageReceiving(controller: String, action: String) 
		{
			super(controller, action);
		}
		
		/* INTERFACE INetPackageReceiving */
		
		public function fill(data: Object): void 
		{
			message = data.message;
		}
		
	}

}