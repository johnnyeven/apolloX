package utils.monitor 
{
	import apollo.center.CResourceCenter;
	import apollo.configuration.GlobalContextConfig;
	import apollo.network.data.CResourceParameter;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author Johnny.EVE
	 */
	public class CMonitorResource extends Sprite
	{
		private var numFrames: Number = 0;
		private var interval: Number = 50;
		private var textField: TextField; 
		
		public function CMonitorResource()
		{
			// 文本实例的样式
			var my_fmt: TextFormat = new TextFormat();
			my_fmt.bold = true;
			my_fmt.font = "Arial";
			my_fmt.size = 14;
			my_fmt.color = 0xFF0000;

			textField = new TextField();
			textField.autoSize = TextFieldAutoSize.NONE;
			textField.y = 25;
			textField.width = 500;
			textField.height = 100;
			textField.text = "";
			addChild(textField);

			textField.defaultTextFormat = my_fmt;
			textField.selectable = false

			this.addEventListener(Event.ADDED, onAdded);
		}

		private function onAdded(event:Event): void
		{
			this.stage.addEventListener(Event.ENTER_FRAME, update, false, 0);
		}
		
		private function update(event:Event): void
		{
			if (++numFrames >= interval)
			{
				var list: Dictionary = CResourceCenter.getInstance().getResourceList();
				textField.text = "";
				for (var key: Object in list)
				{
					var resource: CResourceParameter = list[key] as CResourceParameter;
					textField.appendText("资源" + key + "(" + resource.resourceName + "): " + Math.floor(resource.resourceAmount) + ", 变化率: " + resource.resourceModified + "单位/" + GlobalContextConfig.resourceDelay + "秒\n");
				}
				numFrames = 0;
			}
		}
	}

}