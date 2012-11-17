package utils.monitor 
{
	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Johnny.EVE
	 */
	public class CMonitorConsole extends Sprite 
	{
		private static var instance: CMonitorConsole;
		private static var allowInstance: Boolean = false;
		private var consoleText: TextField;
		private var my_fmt: TextFormat;
		
		public function CMonitorConsole() 
		{
			if (!allowInstance)
			{
				throw new IllegalOperationError("CMonitorConsole不允许实例化");
			}
			my_fmt = new TextFormat();
			my_fmt.bold = true;
			my_fmt.font = "Arial";
			my_fmt.size = 12;
			my_fmt.color = 0xFF0000;

			consoleText = new TextField();
			consoleText.autoSize = TextFieldAutoSize.NONE;
			consoleText.y = 540;
			consoleText.width = 960;
			consoleText.height = 100;
			addChild(consoleText);

			consoleText.defaultTextFormat = my_fmt;
			consoleText.selectable = false
		}
		
		public static function getInstance(): CMonitorConsole
		{
			if (instance == null)
			{
				allowInstance = true;
				instance = new CMonitorConsole();
				allowInstance = false;
			}
			return instance;
		}
		
		public function log(str: String): void
		{
			consoleText.appendText(str + "\n");
			consoleText.defaultTextFormat = my_fmt;
		}
	}

}