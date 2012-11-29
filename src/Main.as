package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.Security;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.ui.MouseCursorData;
	
	import utils.GameManager;
	import utils.VersionUtils;
	import utils.liteui.component.Label;
	import utils.resource.ResourcePool;
	
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
			setCursorStyle();
			//LoginBGComponent.getInstance().destroy();
			ApplicationFacade.getInstance().start(this);
		}
		
		private function setCursorStyle(): void
		{
			var _mouseData: MouseCursorData = new MouseCursorData();
			_mouseData.data = new Vector.<BitmapData>();
			_mouseData.frameRate = 20;
			var _bitmap: Bitmap;
			for(var i: int = 1; i<=36; i++)
			{
				_bitmap = ResourcePool.getResource("ui.cursor.Cursor1_" + i) as Bitmap;
				_mouseData.data.push(_bitmap.bitmapData);
			}
			Mouse.registerCursor(MouseCursor.ARROW, _mouseData);
			
			_mouseData = new MouseCursorData();
			_mouseData.data = new Vector.<BitmapData>();
			_mouseData.data.push((ResourcePool.getResource("ui.cursor.Link") as Bitmap).bitmapData);
			Mouse.registerCursor(MouseCursor.BUTTON, _mouseData);
			
			_mouseData = new MouseCursorData();
			_mouseData.data = new Vector.<BitmapData>();
			_mouseData.data.push((ResourcePool.getResource("ui.cursor.Input") as Bitmap).bitmapData);
			Mouse.registerCursor(MouseCursor.IBEAM, _mouseData);
			
			Mouse.cursor = MouseCursor.ARROW;
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