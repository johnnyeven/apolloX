package view
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.getDefinitionByName;
	
	public class PromptComponent extends Sprite
	{
		private var _textField: TextField;
		
		public function PromptComponent()
		{
			super();
			
			var _class: Class = getDefinitionByName("ui.PromptSkin") as Class;
			var _skin: Sprite = new _class();
			addChild(_skin);
			
			_textField = _skin.getChildByName("promptTitle") as TextField;
			_textField.autoSize = TextFieldAutoSize.CENTER;
			title = "";
		}
		
		public function get title(): String
		{
			return _textField.text;
		}
		
		public function set title(value: String): void
		{
			_textField.text = value;
			_textField.autoSize = TextFieldAutoSize.CENTER;
		}
	}
}