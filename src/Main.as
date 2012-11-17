package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.Security;
	
	import utils.GameManager;
	import utils.liteui.component.Label;
	import utils.VersionUtils;
	
	import view.login.LoginBGComponent;
	
	[SWF(width="1028", height="600", backgroundColor="0x000000",frameRate="30")]
	public class Main extends GameManager
	{
		public function Main()
		{
//			if(stage)
//			{
//				init();
//			}
//			else
//			{
//				addEventListener(Event.ADDED_TO_STAGE, init);
//			}
			Security.allowDomain("*");
		}
		
		public function init(evt: Event = null): void
		{
			if(evt)
			{
				removeEventListener(Event.ADDED_TO_STAGE, init);
			}
			CONFIG::DebugMode
			{
				showVersion();
			}
			//LoginBGComponent.getInstance().destroy();
			ApplicationFacade.getInstance().start(this);
		}
		
		private function showVersion(): void
		{
			var _label: Label = new Label();
			_label.textWidth = 200;
			_label.text = VersionUtils.getVersion("version");
			_label.x = container.stageWidth - _label.textWidth;
			_label.y = container.stageHeight - _label.height;
			_label.color = 0xFFFFFF;
			instance.addInfo(_label);
		}
	}
}