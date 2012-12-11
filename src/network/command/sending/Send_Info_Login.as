package network.command.sending 
{
	import utils.configuration.ConnectorContextConfig;
	import utils.network.command.sending.CNetPackageSending;

	/**
	 * ...
	 * @author johnnyeven
	 */
	public class Send_Info_Login extends CNetPackageSending 
	{
		public var UserName: String;
		public var UserPass: String;
		
		public function Send_Info_Login() 
		{
			super(ConnectorContextConfig.CONTROLLER_INFO, ConnectorContextConfig.ACTION_LOGIN);
		}
		
		override public function fill():void 
		{
			super.fill();
			
			_urlVariables.user_name = UserName;
			_urlVariables.user_pass = UserPass;
			
			generateCode();
		}
		
		override protected function generateCode(): void
		{
			var check: Array = new Array(_urlVariables.user_name, _urlVariables.user_pass, _urlVariables.game_id, _urlVariables.server_section);
			_urlVariables.check_code = generateArrayCode(check);
		}
	}

}