package utils.network.command.sending 
{
	import utils.configuration.ConnectorContextConfig;
	import proxy.LoginProxy;
	
	/**
	 * ...
	 * @author johnnyeven
	 */
	public class Send_Info_QuickStart extends CNetPackageSending 
	{
		public var GameId: String;
		
		public function Send_Info_QuickStart() 
		{
			super(ConnectorContextConfig.CONTROLLER_INFO, ConnectorContextConfig.ACTION_QUICK_START);
			flag = LoginProxy.QUICK_START;
		}
		
		override public function fill():void 
		{
			super.fill();
			
			_urlVariables.game_id = GameId;
			
			generateCode();
		}
		
		override protected function generateCode(): void
		{
			var check: Array = new Array(_urlVariables.game_id);
			_urlVariables.check_code = generateArrayCode(check);
		}
	}

}