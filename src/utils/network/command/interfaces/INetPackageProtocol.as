package utils.network.command.interfaces 
{
	
	/**
	 * ...
	 * @author johnnyeven
	 */
	public interface INetPackageProtocol 
	{
		function get controller(): String;
		function get action(): String;
	}
	
}