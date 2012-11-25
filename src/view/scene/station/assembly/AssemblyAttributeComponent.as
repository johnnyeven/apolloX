package view.scene.station.assembly
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	
	import utils.liteui.component.Label;
	import utils.liteui.core.Component;
	import utils.resource.ResourcePool;
	
	public class AssemblyAttributeComponent extends Component
	{
		private var _scoreIcon: MovieClip;
		private var _lblScoreLabel: Label;
		private var _lblScore: Label;
		
		private var _lblSheildLabel: Label;
		private var _sheildIcon: MovieClip;
		private var _lblCurrentSheildLabel: Label;
		private var _lblCurrentSheild: Label;
		private var _lblMaxSheildLabel: Label;
		private var _lblMaxSheild: Label;
		private var _lblSheildResistanceLabel: Label;
		private var _lblSheildResistance1Label: Label;
		private var _lblSheildResistance1: Label;
		private var _lblSheildResistance2Label: Label;
		private var _lblSheildResistance2: Label;
		private var _lblSheildResistance3Label: Label;
		private var _lblSheildResistance3: Label;
		private var _lblSheildResistance4Label: Label;
		private var _lblSheildResistance4: Label;
		
		private var _lblArmorLabel: Label;
		private var _armorIcon: MovieClip;
		private var _lblCurrentArmorLabel: Label;
		private var _lblCurrentArmor: Label;
		private var _lblMaxArmorLabel: Label;
		private var _lblMaxArmor: Label;
		private var _lblArmorResistanceLabel: Label;
		private var _lblArmorResistance1Label: Label;
		private var _lblArmorResistance1: Label;
		private var _lblArmorResistance2Label: Label;
		private var _lblArmorResistance2: Label;
		private var _lblArmorResistance3Label: Label;
		private var _lblArmorResistance3: Label;
		private var _lblArmorResistance4Label: Label;
		private var _lblArmorResistance4: Label;
		
		private var _lblConstructLabel: Label;
		private var _constructIcon: MovieClip;
		private var _lblCurrentConstructLabel: Label;
		private var _lblCurrentConstruct: Label;
		private var _lblMaxConstructLabel: Label;
		private var _lblMaxConstruct: Label;
		private var _lblConstructResistanceLabel: Label;
		private var _lblConstructResistance1Label: Label;
		private var _lblConstructResistance1: Label;
		private var _lblConstructResistance2Label: Label;
		private var _lblConstructResistance2: Label;
		private var _lblConstructResistance3Label: Label;
		private var _lblConstructResistance3: Label;
		private var _lblConstructResistance4Label: Label;
		private var _lblConstructResistance4: Label;
		
		public function AssemblyAttributeComponent()
		{
			super(ResourcePool.getResource("assets.scene1Station.assembly.attribute") as DisplayObjectContainer);
			
			_scoreIcon = getSkin("scoreIcon") as MovieClip;
			_lblScoreLabel = getUI(Label, "lblScore") as Label;
			_lblScore = getUI(Label, "score") as Label;
			
			_lblSheildLabel = getUI(Label, "lblSheild") as Label;
			_sheildIcon = getSkin("sheildIcon") as MovieClip;
			_lblCurrentSheildLabel = getUI(Label, "lblCurrentSheild") as Label;
			_lblCurrentSheild = getUI(Label, "currentSheild") as Label;
			_lblMaxSheildLabel = getUI(Label, "lblMaxSheild") as Label;
			_lblMaxSheild = getUI(Label, "maxSheild") as Label;
			_lblSheildResistanceLabel = getUI(Label, "lblSheildResistance") as Label;
			_lblSheildResistance1Label = getUI(Label, "lblSheildResistance1") as Label;
			_lblSheildResistance1 = getUI(Label, "sheildResistance1") as Label;
			_lblSheildResistance2Label = getUI(Label, "lblSheildResistance2") as Label;
			_lblSheildResistance2 = getUI(Label, "sheildResistance2") as Label;
			_lblSheildResistance3Label = getUI(Label, "lblSheildResistance3") as Label;
			_lblSheildResistance3 = getUI(Label, "sheildResistance3") as Label;
			_lblSheildResistance4Label = getUI(Label, "lblSheildResistance4") as Label;
			_lblSheildResistance4 = getUI(Label, "sheildResistance4") as Label;
			
			_lblArmorLabel = getUI(Label, "lblArmor") as Label;
			_armorIcon = getSkin("armorIcon") as MovieClip;
			_lblCurrentArmorLabel = getUI(Label, "lblCurrentArmor") as Label;
			_lblCurrentArmor = getUI(Label, "currentArmor") as Label;
			_lblMaxArmorLabel = getUI(Label, "lblMaxArmor") as Label;
			_lblMaxArmor = getUI(Label, "maxArmor") as Label;
			_lblArmorResistanceLabel = getUI(Label, "lblArmorResistance") as Label;
			_lblArmorResistance1Label = getUI(Label, "lblArmorResistance1") as Label;
			_lblArmorResistance1 = getUI(Label, "armorResistance1") as Label;
			_lblArmorResistance2Label = getUI(Label, "lblArmorResistance2") as Label;
			_lblArmorResistance2 = getUI(Label, "armorResistance2") as Label;
			_lblArmorResistance3Label = getUI(Label, "lblArmorResistance3") as Label;
			_lblArmorResistance3 = getUI(Label, "armorResistance3") as Label;
			_lblArmorResistance4Label = getUI(Label, "lblArmorResistance4") as Label;
			_lblArmorResistance4 = getUI(Label, "armorResistance4") as Label;
			
			_lblConstructLabel = getUI(Label, "lblConstruct") as Label;
			_constructIcon = getSkin("constructIcon") as MovieClip;
			_lblCurrentConstructLabel = getUI(Label, "lblCurrentConstruct") as Label;
			_lblCurrentConstruct = getUI(Label, "currentConstruct") as Label;
			_lblMaxConstructLabel = getUI(Label, "lblMaxConstruct") as Label;
			_lblMaxConstruct = getUI(Label, "maxConstruct") as Label;
			_lblConstructResistanceLabel = getUI(Label, "lblConstructResistance") as Label;
			_lblConstructResistance1Label = getUI(Label, "lblConstructResistance1") as Label;
			_lblConstructResistance1 = getUI(Label, "constructResistance1") as Label;
			_lblConstructResistance2Label = getUI(Label, "lblConstructResistance2") as Label;
			_lblConstructResistance2 = getUI(Label, "constructResistance2") as Label;
			_lblConstructResistance3Label = getUI(Label, "lblConstructResistance3") as Label;
			_lblConstructResistance3 = getUI(Label, "constructResistance3") as Label;
			_lblConstructResistance4Label = getUI(Label, "lblConstructResistance4") as Label;
			_lblConstructResistance4 = getUI(Label, "constructResistance4") as Label;
		}
	}
}