package utils.monitor 
{
	import apollo.configuration.GlobalContextConfig;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author Johnny.EVE
	 */
	public class CMonitorFPS extends Sprite
	{
		private var numFrames: Number = 0;
		private var interval: Number = 10;
		private var startTime: Number;
		private var fpsText: TextField;
		
		public function CMonitorFPS()
		{
			startTime = getTimer();

			// 文本实例的样式
			var my_fmt: TextFormat = new TextFormat();
			my_fmt.bold = true;
			my_fmt.font = "Arial";
			my_fmt.size = 14;
			my_fmt.color = 0xFF0000;

			fpsText = new TextField();
			fpsText.autoSize = "left";
			fpsText.text = "loading";
			addChild(fpsText);

			fpsText.defaultTextFormat = my_fmt;
			fpsText.selectable = false

			this.addEventListener(Event.ADDED, onAdded);
		}

		private function onAdded(event:Event): void
		{
			this.stage.addEventListener(Event.ENTER_FRAME, update, false, 0);
		}
		
		private function update(event:Event): void
		{
			if (++numFrames == interval)
			{
				var now:Number = getTimer();
				var elapsedSeconds: Number = (now - startTime) / 1000;
				var actualFPS:Number = numFrames / elapsedSeconds;
				fpsText.text = "Timer: " + GlobalContextConfig.Timer + ", FPS: " + actualFPS.toFixed(2);
				startTime = now;
				numFrames = 0;
			}
		}
	}

}