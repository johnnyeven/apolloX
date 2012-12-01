package view.scene.station.medical
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	
	import parameters.station.MedicalItemListParameter;
	
	import utils.language.LanguageManager;
	import utils.liteui.component.CaptionButton;
	import utils.liteui.component.ImageContainer;
	import utils.liteui.component.Label;
	import utils.liteui.core.Component;
	import utils.resource.ResourcePool;
	
	public class MedicalListItemComponent extends Component
	{
		private var _avatar: ImageContainer;
		private var _lblCloneName: Label;
		private var _lblSkillPoint: Label;
		private var _lblCost: Label;
		private var _lblCurrent: Label;
		private var _btnUpgrade: CaptionButton;
		private var _info: MedicalItemListParameter;
		
		public function MedicalListItemComponent()
		{
			super(ResourcePool.getResource("assets.scene1Station.medical.ListItem") as DisplayObjectContainer);
			
			_avatar = getUI(ImageContainer, "avatar") as ImageContainer;
			_lblCloneName = getUI(Label, "cloneName") as Label;
			_lblSkillPoint = getUI(Label, "skillPoint") as Label;
			_lblCost = getUI(Label, "cost") as Label;
			_lblCurrent = getUI(Label, "current") as Label;
			_btnUpgrade = getUI(CaptionButton, "btnUpgrade") as CaptionButton;
			
			sortChildIndex();
			
			_lblCurrent.visible = false;
		}
		
		override public function dispose():void
		{
			super.dispose();
			_info = null;
		}

		public function get info():MedicalItemListParameter
		{
			return _info;
		}

		public function set info(value:MedicalItemListParameter):void
		{
			if(value != null)
			{
				_info = value;
				
				_avatar.source = value.avatar;
				_lblCloneName.text = value.cloneName;
				_lblSkillPoint.text = value.skillPoint.toString();
				if(value.cost > 0)
				{
					_lblCost.text = value.cost.toString() + " ISK";
				}
				else
				{
					_lblCost.text = LanguageManager.getInstance().lang("medical_cost_free");
				}
				
				if(value.isCurrent)
				{
					_lblCurrent.visible = true;
					_btnUpgrade.visible = false;
				}
				else
				{
					_lblCurrent.visible = false;
					_btnUpgrade.visible = true;
				}
			}
		}
	}
}