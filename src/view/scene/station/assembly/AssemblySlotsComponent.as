package view.scene.station.assembly
{
	import events.AssemblyEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import utils.liteui.component.ImageContainer;
	import utils.liteui.core.Component;
	import utils.resource.ResourcePool;
	
	public class AssemblySlotsComponent extends Component
	{
		private var _avatar: ImageContainer;
		private var _mc: MovieClip;
		private var _slotArray: Array;
		private var _slotIndex: int = 0;
		
		public function AssemblySlotsComponent()
		{
			super(ResourcePool.getResource("assets.scene1Station.assembly.mainSlots") as MovieClip);
			
			_avatar = getUI(ImageContainer, "avatar") as ImageContainer;
			_mc = getSkin("mc") as MovieClip;
			
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