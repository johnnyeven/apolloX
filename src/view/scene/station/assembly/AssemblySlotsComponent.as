package view.scene.station.assembly
{
	import com.greensock.TweenLite;
	
	import events.AssemblyEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import utils.enum.ProgressBarType;
	import utils.liteui.component.ImageContainer;
	import utils.liteui.component.Label;
	import utils.liteui.component.ProgressBar;
	import utils.liteui.core.Component;
	import utils.resource.ResourcePool;
	
	public class AssemblySlotsComponent extends Component
	{
		private var _avatar: ImageContainer;
		private var _leftProgress: ProgressBar;
		private var _rightProgress: ProgressBar;
		private var _lblEnergyLabel: Label;
		private var _lblEnergy: Label;
		private var _lblChargeLabel: Label;
		private var _lblCharge: Label;
		private var _mcSeperator: MovieClip;
		private var _mc: MovieClip;
		private var _slotArray: Array;
		private var _slotIndex: int = 0;
		
		public function AssemblySlotsComponent()
		{
			super(ResourcePool.getResource("assets.scene1Station.assembly.mainSlots") as MovieClip);
			
			_avatar = getUI(ImageContainer, "avatar") as ImageContainer;
			_leftProgress = getUI(ProgressBar, "leftProgressBar") as ProgressBar;
			_rightProgress = getUI(ProgressBar, "rightProgressBar") as ProgressBar;
			_lblEnergyLabel = getUI(Label, "lblEnergy") as Label;
			_lblEnergy = getUI(Label, "energy") as Label;
			_lblChargeLabel = getUI(Label, "lblCharge") as Label;
			_lblCharge = getUI(Label, "charge") as Label;
			_mcSeperator = getSkin("seperator") as MovieClip;
			_mc = getSkin("mc") as MovieClip;
			
			_leftProgress.type = ProgressBarType.MOVIE;
			_rightProgress.type = ProgressBarType.MOVIE;
			_leftProgress.alpha = 0;
			_rightProgress.alpha = 0;
			_lblEnergyLabel.alpha = 0;
			_lblEnergy.alpha = 0;
			_lblChargeLabel.alpha = 0;
			_lblCharge.alpha = 0;
			_mcSeperator.scaleY = 0;
			
			sortChildIndex();
			
			_avatar.source = "resources/assets/avatar.png";
			_mc.addEventListener(AssemblyEvent.SHOW_SLOTS, onShowSlots);
			addEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		private function onShowSlots(evt: AssemblyEvent): void
		{
			_slotArray = new Array();
			
			var timer: Timer = new Timer(50);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			timer.start();
			
			_leftProgress.initProgressBar();
			_rightProgress.initProgressBar();
			TweenLite.to(_leftProgress, .5, {alpha: 1, onComplete: function(): void {
				_leftProgress.percent = .6;
			}});
			TweenLite.to(_rightProgress, .5, {alpha: 1, onComplete: function(): void {
				_rightProgress.percent = 1;
			}});
			TweenLite.to(_mcSeperator, .5, {scaleY: 1});
			TweenLite.to(_lblEnergyLabel, .5, {alpha: 1});
			TweenLite.to(_lblEnergy, .5, {alpha: 1});
			TweenLite.to(_lblChargeLabel, .5, {alpha: 1});
			TweenLite.to(_lblCharge, .5, {alpha: 1});
		}
		
		private function onTimer(evt: TimerEvent): void
		{
			if(_slotIndex >= 24)
			{
				var timer: Timer = evt.target as Timer;
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER, onTimer);
				timer = null;
				onProgressShow();
				return;
			}
			_slotArray.push(new AssemblySlotItemComponent(ResourcePool.getResource("assets.scene1Station.assembly.slot" + (_slotIndex+1)) as DisplayObjectContainer));
			addChild(_slotArray[_slotArray.length-1]);
			_slotIndex++;
		}
		
		private function onMouseClick(evt: MouseEvent): void
		{
			_mc.gotoAndStop("last");
			removeEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		private function onProgressShow(): void
		{
			//TODO johnnyeven: 显示能量
		}
	}
}