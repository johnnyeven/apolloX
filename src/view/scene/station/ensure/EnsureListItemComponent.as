package view.scene.station.ensure
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	
	import parameters.station.EnsureItemListParameter;
	
	import utils.language.LanguageManager;
	import utils.liteui.component.CaptionButton;
	import utils.liteui.component.ImageContainer;
	import utils.liteui.component.Label;
	import utils.liteui.core.Component;
	import utils.resource.ResourcePool;
	
	public class EnsureListItemComponent extends Component
	{
		private var _avatar: ImageContainer;
		private var _lblShipName: Label;
		private var _lblLevel: Label;
		private var _lblEndTime: Label;
		private var _btnSelect: CaptionButton;
		private var _info: EnsureItemListParameter;
		
		public function EnsureListItemComponent()
		{
			super(ResourcePool.getResource("assets.scene1Station.ensure.ListItem") as DisplayObjectContainer);
			
			_avatar = getUI(ImageContainer, "avatar") as ImageContainer;
			_lblShipName = getUI(Label, "shipName") as Label;
			_lblLevel = getUI(Label, "level") as Label;
			_lblEndTime = getUI(Label, "endTime") as Label;
			_btnSelect = getUI(CaptionButton, "btnSelect") as CaptionButton;
			
			sortChildIndex();
		}
		
		override public function dispose():void
		{
			super.dispose();
			_info = null;
		}

		public function get info():EnsureItemListParameter
		{
			return _info;
		}

		public function set info(value:EnsureItemListParameter):void
		{
			if(value != null)
			{
				_info = value;
				
				_avatar.source = value.avatar;
				_lblShipName.text = value.shipName;
				
				if(value.level > 0)
				{
					_lblLevel.text = value.level.toString();
					_lblLevel.color = 0xFFFFFF;
				}
				else
				{
					_lblLevel.text = LanguageManager.getInstance().lang("ensure_level_zero");
					_lblLevel.color = 0xFF0000;
				}
				if(value.endTime > 0)
				{
					_lblEndTime.text = value.endTime.toString();
				}
				else
				{
					_lblEndTime.text = LanguageManager.getInstance().lang("ensure_end_time_zero");
				}
			}
		}
	}
}