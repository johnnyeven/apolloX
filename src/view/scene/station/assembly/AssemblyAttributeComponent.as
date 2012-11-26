package view.scene.station.assembly
{
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	
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
		
		private var _sheildTitle: MovieClip;
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
		
		private var _armorTitle: MovieClip;
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
		
		private var _constructTitle: MovieClip;
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
		
		private var _middleFrame: MovieClip;
		private var _saomiaoIcon: MovieClip;
		private var _xinhaoIcon: MovieClip;
		private var _ganyingqiIcon: MovieClip;
		private var _tuijinliIcon: MovieClip;
		private var _lblSaomiaoLabel: Label;
		private var _lblSaomiao: Label;
		private var _lblXinhaoLabel: Label;
		private var _lblXinhao: Label;
		private var _lblGanyingqiLabel: Label;
		private var _lblGanyingqi: Label;
		private var _lblTuijinliLabel: Label;
		private var _lblTuijinli: Label;
		
		public function AssemblyAttributeComponent()
		{
			super(ResourcePool.getResource("assets.scene1Station.assembly.attribute") as DisplayObjectContainer);
			
			_scoreIcon = getSkin("scoreIcon") as MovieClip;
			_lblScoreLabel = getUI(Label, "lblScore") as Label;
			_lblScore = getUI(Label, "score") as Label;
			
			_sheildTitle = ResourcePool.getResource("assets.scene1Station.assembly.rightTitle") as MovieClip;
			_sheildTitle.x = 550;
			_sheildTitle.y = 170;
			_sheildTitle.alpha = 0;
			addChild(_sheildTitle);
			
			_armorTitle = ResourcePool.getResource("assets.scene1Station.assembly.rightTitle") as MovieClip;
			_armorTitle.x = 550;
			_armorTitle.y = 170;
			_armorTitle.alpha = 0;
			addChild(_armorTitle);
			
			_constructTitle = ResourcePool.getResource("assets.scene1Station.assembly.rightTitle") as MovieClip;
			_constructTitle.x = 550;
			_constructTitle.y = 256;
			_constructTitle.alpha = 0;
			addChild(_constructTitle);
			
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
			
			_middleFrame = getSkin("middleFrame") as MovieClip;
			_saomiaoIcon = getSkin("saomiaoIcon") as MovieClip;
			_xinhaoIcon = getSkin("xinhaoIcon") as MovieClip;
			_ganyingqiIcon = getSkin("ganyingqiIcon") as MovieClip;
			_tuijinliIcon = getSkin("tuijinliIcon") as MovieClip;
			_lblSaomiaoLabel = getUI(Label, "lblSaomiao") as Label;
			_lblSaomiao = getUI(Label, "saomiao") as Label;
			_lblXinhaoLabel = getUI(Label, "lblXinhao") as Label;
			_lblXinhao = getUI(Label, "xinhao") as Label;
			_lblGanyingqiLabel = getUI(Label, "lblGanyingqi") as Label;
			_lblGanyingqi = getUI(Label, "ganyingqi") as Label;
			_lblTuijinliLabel = getUI(Label, "lblTuijinli") as Label;
			_lblTuijinli = getUI(Label, "tuijinli") as Label;
			
			//sortChildIndex();
			
			_lblSheildLabel.alpha = 0;
			_sheildIcon.alpha = 0;
			_lblCurrentSheildLabel.alpha = 0;
			_lblCurrentSheild.alpha = 0;
			_lblMaxSheildLabel.alpha = 0;
			_lblMaxSheild.alpha = 0;
			_lblSheildResistanceLabel.alpha = 0;
			_lblSheildResistance1Label.alpha = 0;
			_lblSheildResistance1.alpha = 0;
			_lblSheildResistance2Label.alpha = 0;
			_lblSheildResistance2.alpha = 0;
			_lblSheildResistance3Label.alpha = 0;
			_lblSheildResistance3.alpha = 0;
			_lblSheildResistance4Label.alpha = 0;
			_lblSheildResistance4.alpha = 0;
			_lblSheildLabel.x -= 20;
			_sheildIcon.x -= 20;
			_lblCurrentSheildLabel.x -= 20;
			_lblCurrentSheild.x -= 20;
			_lblMaxSheildLabel.x -= 20;
			_lblMaxSheild.x -= 20;
			_lblSheildResistanceLabel.y -= 20;
			_lblSheildResistance1Label.y -= 20;
			_lblSheildResistance1.y -= 20;
			_lblSheildResistance2Label.y -= 20;
			_lblSheildResistance2.y -= 20;
			_lblSheildResistance3Label.y -= 20;
			_lblSheildResistance3.y -= 20;
			_lblSheildResistance4Label.y -= 20;
			_lblSheildResistance4.y -= 20;
			
			_lblArmorLabel.alpha = 0;
			_armorIcon.alpha = 0;
			_lblCurrentArmorLabel.alpha = 0;
			_lblCurrentArmor.alpha = 0;
			_lblMaxArmorLabel.alpha = 0;
			_lblMaxArmor.alpha = 0;
			_lblArmorResistanceLabel.alpha = 0;
			_lblArmorResistance1Label.alpha = 0;
			_lblArmorResistance1.alpha = 0;
			_lblArmorResistance2Label.alpha = 0;
			_lblArmorResistance2.alpha = 0;
			_lblArmorResistance3Label.alpha = 0;
			_lblArmorResistance3.alpha = 0;
			_lblArmorResistance4Label.alpha = 0;
			_lblArmorResistance4.alpha = 0;
			_lblArmorLabel.x -= 20;
			_armorIcon.x -= 20;
			_lblCurrentArmorLabel.x -= 20;
			_lblCurrentArmor.x -= 20;
			_lblMaxArmorLabel.x -= 20;
			_lblMaxArmor.x -= 20;
			_lblArmorResistanceLabel.y -= 20;
			_lblArmorResistance1Label.y -= 20;
			_lblArmorResistance1.y -= 20;
			_lblArmorResistance2Label.y -= 20;
			_lblArmorResistance2.y -= 20;
			_lblArmorResistance3Label.y -= 20;
			_lblArmorResistance3.y -= 20;
			_lblArmorResistance4Label.y -= 20;
			_lblArmorResistance4.y -= 20;
			
			_lblConstructLabel.alpha = 0;
			_constructIcon.alpha = 0;
			_lblCurrentConstructLabel.alpha = 0;
			_lblCurrentConstruct.alpha = 0;
			_lblMaxConstructLabel.alpha = 0;
			_lblMaxConstruct.alpha = 0;
			_lblConstructResistanceLabel.alpha = 0;
			_lblConstructResistance1Label.alpha = 0;
			_lblConstructResistance1.alpha = 0;
			_lblConstructResistance2Label.alpha = 0;
			_lblConstructResistance2.alpha = 0;
			_lblConstructResistance3Label.alpha = 0;
			_lblConstructResistance3.alpha = 0;
			_lblConstructResistance4Label.alpha = 0;
			_lblConstructResistance4.alpha = 0;
			_lblConstructLabel.x -= 20;
			_constructIcon.x -= 20;
			_lblCurrentConstructLabel.x -= 20;
			_lblCurrentConstruct.x -= 20;
			_lblMaxConstructLabel.x -= 20;
			_lblMaxConstruct.x -= 20;
			_lblConstructResistanceLabel.y -= 20;
			_lblConstructResistance1Label.y -= 20;
			_lblConstructResistance1.y -= 20;
			_lblConstructResistance2Label.y -= 20;
			_lblConstructResistance2.y -= 20;
			_lblConstructResistance3Label.y -= 20;
			_lblConstructResistance3.y -= 20;
			_lblConstructResistance4Label.y -= 20;
			_lblConstructResistance4.y -= 20;
			
			_middleFrame.alpha = 0;
			_saomiaoIcon.alpha = 0;
			_xinhaoIcon.alpha = 0;
			_ganyingqiIcon.alpha = 0;
			_tuijinliIcon.alpha = 0;
			_lblSaomiaoLabel.alpha = 0;
			_lblSaomiao.alpha = 0;
			_lblXinhaoLabel.alpha = 0;
			_lblXinhao.alpha = 0;
			_lblGanyingqiLabel.alpha = 0;
			_lblGanyingqi.alpha = 0;
			_lblTuijinliLabel.alpha = 0;
			_lblTuijinli.alpha = 0;
			_lblSaomiaoLabel.x -= 20;
			_lblSaomiao.x -= 20;
			_lblXinhaoLabel.x -= 20;
			_lblXinhao.x -= 20;
			_lblGanyingqiLabel.x -= 20;
			_lblGanyingqi.x -= 20;
			_lblTuijinliLabel.x -= 20;
			_lblTuijinli.x -= 20;
			
			var _tl1: TimelineLite;
			var _tl2: TimelineLite;
			var _tl3: TimelineLite;
			var _tl4: TimelineLite;
			TweenLite.to(_sheildTitle, .5, {alpha: 1, onComplete: function(): void
			{
				_tl1 = new TimelineLite({onComplete: function(): void
				{
					_tl1.clear();
					_tl1 = new TimelineLite({onComplete: function(): void
					{
						_tl1.clear();
					}});
					_tl1.autoRemoveChildren = true;
					_tl1.insert(TweenLite.to(_lblSheildResistanceLabel, .5, {y: _lblSheildResistanceLabel.y + 20, alpha: 1}));
					_tl1.insert(TweenLite.to(_lblSheildResistance1Label, .5, {y: _lblSheildResistance1Label.y + 20, alpha: 1}));
					_tl1.insert(TweenLite.to(_lblSheildResistance1, .5, {y: _lblSheildResistance1.y + 20, alpha: 1}));
					_tl1.insert(TweenLite.to(_lblSheildResistance2Label, .5, {y: _lblSheildResistance2Label.y + 20, alpha: 1}));
					_tl1.insert(TweenLite.to(_lblSheildResistance2, .5, {y: _lblSheildResistance2.y + 20, alpha: 1}));
					_tl1.insert(TweenLite.to(_lblSheildResistance3Label, .5, {y: _lblSheildResistance3Label.y + 20, alpha: 1}));
					_tl1.insert(TweenLite.to(_lblSheildResistance3, .5, {y: _lblSheildResistance3.y + 20, alpha: 1}));
					_tl1.insert(TweenLite.to(_lblSheildResistance4Label, .5, {y: _lblSheildResistance4Label.y + 20, alpha: 1}));
					_tl1.insert(TweenLite.to(_lblSheildResistance4, .5, {y: _lblSheildResistance4.y + 20, alpha: 1}));
				}});
				_tl1.autoRemoveChildren = true;
				_tl1.insert(TweenLite.to(_lblSheildLabel, .5, {x: _lblSheildLabel.x + 20, alpha: 1}));
				_tl1.insert(TweenLite.to(_sheildIcon, .5, {x: _sheildIcon.x + 20, alpha: 1, delay: .2}));
				_tl1.insert(TweenLite.to(_lblCurrentSheildLabel, .5, {x: _lblCurrentSheildLabel.x + 20, alpha: 1, delay: .4}));
				_tl1.insert(TweenLite.to(_lblCurrentSheild, .5, {x: _lblCurrentSheild.x + 20, alpha: 1, delay: .6}));
				_tl1.insert(TweenLite.to(_lblMaxSheildLabel, .5, {x: _lblMaxSheildLabel.x + 20, alpha: 1, delay: .8}));
				_tl1.insert(TweenLite.to(_lblMaxSheild, .5, {x: _lblMaxSheild.x + 20, alpha: 1, delay: 1}));
				TweenLite.to(_armorTitle, .5, {alpha: 1, y: 256, onComplete: function(): void
				{
					_tl2 = new TimelineLite({onComplete: function(): void
					{
						_tl2.clear();
						_tl2 = new TimelineLite({onComplete: function(): void
						{
							_tl2.clear();
						}});
						_tl2.autoRemoveChildren = true;
						_tl2.insert(TweenLite.to(_lblArmorResistanceLabel, .5, {y: _lblArmorResistanceLabel.y + 20, alpha: 1}));
						_tl2.insert(TweenLite.to(_lblArmorResistance1Label, .5, {y: _lblArmorResistance1Label.y + 20, alpha: 1}));
						_tl2.insert(TweenLite.to(_lblArmorResistance1, .5, {y: _lblArmorResistance1.y + 20, alpha: 1}));
						_tl2.insert(TweenLite.to(_lblArmorResistance2Label, .5, {y: _lblArmorResistance2Label.y + 20, alpha: 1}));
						_tl2.insert(TweenLite.to(_lblArmorResistance2, .5, {y: _lblArmorResistance2.y + 20, alpha: 1}));
						_tl2.insert(TweenLite.to(_lblArmorResistance3Label, .5, {y: _lblArmorResistance3Label.y + 20, alpha: 1}));
						_tl2.insert(TweenLite.to(_lblArmorResistance3, .5, {y: _lblArmorResistance3.y + 20, alpha: 1}));
						_tl2.insert(TweenLite.to(_lblArmorResistance4Label, .5, {y: _lblArmorResistance4Label.y + 20, alpha: 1}));
						_tl2.insert(TweenLite.to(_lblArmorResistance4, .5, {y: _lblArmorResistance4.y + 20, alpha: 1}));
					}});
					_tl2.autoRemoveChildren = true;
					_tl2.insert(TweenLite.to(_lblArmorLabel, .5, {x: _lblArmorLabel.x + 20, alpha: 1}));
					_tl2.insert(TweenLite.to(_armorIcon, .5, {x: _armorIcon.x + 20, alpha: 1, delay: .2}));
					_tl2.insert(TweenLite.to(_lblCurrentArmorLabel, .5, {x: _lblCurrentArmorLabel.x + 20, alpha: 1, delay: .4}));
					_tl2.insert(TweenLite.to(_lblCurrentArmor, .5, {x: _lblCurrentArmor.x + 20, alpha: 1, delay: .6}));
					_tl2.insert(TweenLite.to(_lblMaxArmorLabel, .5, {x: _lblMaxArmorLabel.x + 20, alpha: 1, delay: .8}));
					_tl2.insert(TweenLite.to(_lblMaxArmor, .5, {x: _lblMaxArmor.x + 20, alpha: 1, delay: 1}));
					TweenLite.to(_constructTitle, .5, {alpha: 1, y: 339, onComplete: function(): void
					{
						_tl3 = new TimelineLite({onComplete: function(): void
						{
							_tl3.clear();
							_tl3 = new TimelineLite({onComplete: function(): void
							{
								_tl3.clear();
								_tl4 = new TimelineLite({onComplete: function(): void
								{
									_tl4.clear();
								}});
								_tl4.insert(TweenLite.to(_middleFrame, .5, {alpha: 1}));
								_tl4.insert(TweenLite.to(_saomiaoIcon, .5, {alpha: 1}), .5);
								_tl4.insert(TweenLite.to(_xinhaoIcon, .5, {alpha: 1}), .7);
								_tl4.insert(TweenLite.to(_ganyingqiIcon, .5, {alpha: 1}), .9);
								_tl4.insert(TweenLite.to(_tuijinliIcon, .5, {alpha: 1}), 1.1);
								_tl4.insert(TweenLite.to(_lblSaomiaoLabel, .5, {alpha: 1, x: "20"}), .7);
								_tl4.insert(TweenLite.to(_lblSaomiao, .5, {alpha: 1, x: "20"}), .9);
								_tl4.insert(TweenLite.to(_lblXinhaoLabel, .5, {alpha: 1, x: "20"}), .9);
								_tl4.insert(TweenLite.to(_lblXinhao, .5, {alpha: 1, x: "20"}), 1.1);
								_tl4.insert(TweenLite.to(_lblGanyingqiLabel, .5, {alpha: 1, x: "20"}), 1.1);
								_tl4.insert(TweenLite.to(_lblGanyingqi, .5, {alpha: 1, x: "20"}), 1.3);
								_tl4.insert(TweenLite.to(_lblTuijinliLabel, .5, {alpha: 1, x: "20"}), 1.3);
								_tl4.insert(TweenLite.to(_lblTuijinli, .5, {alpha: 1, x: "20"}), 1.5);
							}});
							_tl3.autoRemoveChildren = true;
							_tl3.insert(TweenLite.to(_lblConstructResistanceLabel, .5, {y: _lblConstructResistanceLabel.y + 20, alpha: 1}));
							_tl3.insert(TweenLite.to(_lblConstructResistance1Label, .5, {y: _lblConstructResistance1Label.y + 20, alpha: 1}));
							_tl3.insert(TweenLite.to(_lblConstructResistance1, .5, {y: _lblConstructResistance1.y + 20, alpha: 1}));
							_tl3.insert(TweenLite.to(_lblConstructResistance2Label, .5, {y: _lblConstructResistance2Label.y + 20, alpha: 1}));
							_tl3.insert(TweenLite.to(_lblConstructResistance2, .5, {y: _lblConstructResistance2.y + 20, alpha: 1}));
							_tl3.insert(TweenLite.to(_lblConstructResistance3Label, .5, {y: _lblConstructResistance3Label.y + 20, alpha: 1}));
							_tl3.insert(TweenLite.to(_lblConstructResistance3, .5, {y: _lblConstructResistance3.y + 20, alpha: 1}));
							_tl3.insert(TweenLite.to(_lblConstructResistance4Label, .5, {y: _lblConstructResistance4Label.y + 20, alpha: 1}));
							_tl3.insert(TweenLite.to(_lblConstructResistance4, .5, {y: _lblConstructResistance4.y + 20, alpha: 1}));
						}});
						_tl3.autoRemoveChildren = true;
						_tl3.insert(TweenLite.to(_lblConstructLabel, .5, {x: _lblConstructLabel.x + 20, alpha: 1}));
						_tl3.insert(TweenLite.to(_constructIcon, .5, {x: _constructIcon.x + 20, alpha: 1, delay: .2}));
						_tl3.insert(TweenLite.to(_lblCurrentConstructLabel, .5, {x: _lblCurrentConstructLabel.x + 20, alpha: 1, delay: .4}));
						_tl3.insert(TweenLite.to(_lblCurrentConstruct, .5, {x: _lblCurrentConstruct.x + 20, alpha: 1, delay: .6}));
						_tl3.insert(TweenLite.to(_lblMaxConstructLabel, .5, {x: _lblMaxConstructLabel.x + 20, alpha: 1, delay: .8}));
						_tl3.insert(TweenLite.to(_lblMaxConstruct, .5, {x: _lblMaxConstruct.x + 20, alpha: 1, delay: 1}));
					}});
				}});
			}});
		}
	}
}