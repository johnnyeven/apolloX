package parameters.station
{
	import utils.network.data.interfaces.IParameterFill;
	
	public class StationCharacterListParameter implements IParameterFill
	{
		private var _avatar: String;
		private var _username: String;
		private var _userdesc: String;
		
		public function StationCharacterListParameter()
		{
		}
		
		public function fill(data:Object):void
		{
			_avatar = data.avatar;
			_username = data.username;
			_userdesc = data.userdesc;
		}

		public function get avatar():String
		{
			return _avatar;
		}

		public function get username():String
		{
			return _username;
		}

		public function get userdesc():String
		{
			return _userdesc;
		}
	}
}