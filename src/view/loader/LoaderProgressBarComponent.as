package view.loader
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.getDefinitionByName;
	//import ui.loader.LoaderProgressBarSkin;
	
	public class LoaderProgressBarComponent extends Sprite
	{
		private var _progressBarTitle: TextField;
		private var _progressBarPercentage: TextField;
		private var _progressBarBar: MovieClip;
		private var _progressBarBg: MovieClip;
		private var _percentage: Number;
		private var _barWidth: Number;
		
		public function LoaderProgressBarComponent()
		{
			super();
			var ui: Class = getDefinitionByName("ui.loader.LoaderProgressBarSkin") as Class;
			var skin: MovieClip = new ui();
			//var skin: LoaderProgressBarSkin = new LoaderProgressBarSkin();
			addChild(skin);
			
			_progressBarTitle = skin.getChildByName("progressBarTitle") as TextField;
			_progressBarPercentage = skin.getChildByName("progressBarPercentage") as TextField;
			_progressBarBar = skin.getChildByName("progressBarBar") as MovieClip;
			_progressBarBg = skin.getChildByName("progressBarBg") as MovieClip;
			
			_progressBarTitle.autoSize = TextFieldAutoSize.CENTER;
			_progressBarPercentage.autoSize = TextFieldAutoSize.CENTER;
			
			_barWidth = _progressBarBar.width;
			_progressBarBar.width = 0;
			
			percentage = 0;
			title = "";
		}
		
		public function set title(value: String): void
		{
			_progressBarTitle.text = value;
		}
		
		public function get title(): String
		{
			return _progressBarTitle.text;
		}
		
		public function get percentage(): Number
		{
			return _percentage;
		}
		
		public function set percentage(value: Number): void
		{
			if(value < 0)
			{
				_percentage = 0;
			}
			else if(value > 1 || isNaN(value))
			{
				_percentage = 1;
			}
			else
			{
				_percentage = value;
			}
			_progressBarBar.width = _barWidth * _percentage;
			
			_progressBarPercentage.text = Math.floor(_percentage * 100) + "%";
		}
	}
}