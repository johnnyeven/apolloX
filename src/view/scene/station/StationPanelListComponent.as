package view.scene.station
{
	import flash.display.DisplayObjectContainer;
	
	import parameters.station.StationCharacterListParameter;
	
	import utils.liteui.component.Button;
	import utils.liteui.component.ImageContainer;
	import utils.liteui.component.Label;
	import utils.liteui.core.Component;
	import utils.resource.ResourcePool;
	
	public class StationPanelListComponent extends Component
	{
		private var _avatar: ImageContainer;
		private var _username: Label;
		private var _userdesc: Label;
		private var _btn: Button;
		private var _info: StationCharacterListParameter;
		
		public function StationPanelListComponent()
		{
			super(ResourcePool.getResource("assets.station.ItemList") as DisplayObjectContainer);
			
			_avatar = getUI(ImageContainer, "avatar") as ImageContainer;
			_username = getUI(Label, "username") as Label;
			_userdesc = getUI(Label, "userdesc") as Label;
			_btn = getUI(Button, "btn") as Button;
			
			sortChildIndex();
		}
		
		public function get info(): StationCharacterListParameter
		{
			return _info;
		}
		
		public function set info(value: StationCharacterListParameter): void
		{
			if(value != null)
			{
				_info = value;
				
				_avatar.source = value.avatar;
				_username.text = value.username;
				_userdesc.text = value.userdesc;
			}
		}
	}
}