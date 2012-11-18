package view.scene.station
{
	import flash.display.DisplayObjectContainer;
	
	import utils.liteui.component.ImageContainer;
	import utils.liteui.component.Label;
	import utils.liteui.core.Component;
	
	public class StationOverviewComponent extends Component
	{
		private var _lblShipName: Label;
		private var _lblStatus: Label;
		private var _lblScoreLabel: Label;
		private var _lblScore: Label;
		private var _lblHpLabel: Label;
		private var _lblSheild: Label;
		private var _lblArmor: Label;
		private var _lblConstruction: Label;
		private var _lblSkillLabel: Label;
		private var _lblSkill: Label;
		private var _lblCloneLabel: Label;
		private var _lblCloneSkill: Label;
		private var _imgAvatar: ImageContainer;
		
		public function StationOverviewComponent(_skin:DisplayObjectContainer=null)
		{
			super(_skin);
			
			_lblShipName = getUI(Label, "shipName") as Label;
			_lblStatus = getUI(Label, "status") as Label;
			_lblScoreLabel = getUI(Label, "lblScore") as Label;
			_lblScore = getUI(Label, "score") as Label;
			_lblHpLabel = getUI(Label, "lblHp") as Label;
			_lblSheild = getUI(Label, "sheild") as Label;
			_lblArmor = getUI(Label, "armor") as Label;
			_lblConstruction = getUI(Label, "construction") as Label;
			_lblSkillLabel = getUI(Label, "lblSkill") as Label;
			_lblSkill = getUI(Label, "skill") as Label;
			_lblCloneLabel = getUI(Label, "lblClone") as Label;
			_lblCloneSkill = getUI(Label, "cloneSkill") as Label;
			_imgAvatar = getUI(ImageContainer, "avatar") as ImageContainer;
			
			sortChildIndex();
			
			_imgAvatar.source = "resources/assets/avatar.png";
		}
	}
}