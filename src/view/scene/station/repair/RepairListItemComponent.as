package view.scene.station.repair
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	
	import utils.liteui.component.CaptionButton;
	import utils.liteui.component.ImageContainer;
	import utils.liteui.component.Label;
	import utils.liteui.core.Component;
	import utils.resource.ResourcePool;
	
	public class RepairListItemComponent extends Component
	{
		private var _avatar: ImageContainer;
		private var _lblShipName: Label;
		private var _sheildIcon: MovieClip;
		private var _armorIcon: MovieClip;
		private var _constructIcon: MovieClip;
		private var _lblSheild: Label;
		private var _lblArmor: Label;
		private var _lblConstruction: Label;
		private var _lblCost: Label;
		private var _btnRepair: CaptionButton;
		
		public function RepairListItemComponent()
		{
			super(ResourcePool.getResource("assets.scene1Station.ListItem") as DisplayObjectContainer);
			
			_avatar = getUI(ImageContainer, "avatar") as ImageContainer;
			_lblShipName = getUI(Label, "shipName") as Label;
			_sheildIcon = getSkin("sheildIcon") as MovieClip;
			_armorIcon = getSkin("armorIcon") as MovieClip;
			_constructIcon = getSkin("constructIcon") as MovieClip;
			_lblSheild = getUI(Label, "sheild") as Label;
			_lblArmor = getUI(Label, "armor") as Label;
			_lblConstruction = getUI(Label, "construction") as Label;
			_lblCost = getUI(Label, "cost") as Label;
			_btnRepair = getUI(CaptionButton, "btnRepair") as CaptionButton;
			
			sortChildIndex();
			
			_avatar.source = "resources/assets/small_avatar.png";
		}
	}
}