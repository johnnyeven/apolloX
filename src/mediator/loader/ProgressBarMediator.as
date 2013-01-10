package mediator.loader
{
	import flash.display.Loader;
	import flash.net.URLRequest;
	
	import mediator.StageMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import utils.GameManager;
	import utils.UIUtils;
	
	import view.loader.LoaderProgressBarComponent;
	
	public class ProgressBarMediator extends Mediator implements IMediator
	{
		public static const NAME: String = "ProgressBarMediator";
		
		public static const SHOW_PROGRESSBAR_NOTE: String = "show_progressbar_note";
		public static const HIDE_PROGRESSBAR_NOTE: String = "hide_progressbar_note";
		public static const SET_PROGRESSBAR_TITLE_NOTE: String = "set_progressbar_title_note";
		public static const SET_PROGRESSBAR_PERCENT_NOTE: String = "set_progressbar_percent_note";
		public static const SHOW_RANDOM_BG: String = "show_random_bg";
		public static const HIDE_RANDOM_BG: String = "hide_random_bg";
		
		private var _loader: Loader;
		
		public function ProgressBarMediator(viewComponent:Object=null)
		{
			super(NAME, new LoaderProgressBarComponent());
			_loader = new Loader();
		}
		
		override public function listNotificationInterests():Array
		{
			return [SHOW_PROGRESSBAR_NOTE, HIDE_PROGRESSBAR_NOTE,
				SET_PROGRESSBAR_TITLE_NOTE, SET_PROGRESSBAR_PERCENT_NOTE,
				SHOW_RANDOM_BG, HIDE_RANDOM_BG];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case SHOW_PROGRESSBAR_NOTE:
					showProgressBar();
					break;
				case HIDE_PROGRESSBAR_NOTE:
					hideProgressBar();
					break;
				case SET_PROGRESSBAR_TITLE_NOTE:
					setProgressBarTitle(notification.getBody() as String);
					break;
				case SET_PROGRESSBAR_PERCENT_NOTE:
					setProgressBarPercent(notification.getBody() as Number);
					break;
				case SHOW_RANDOM_BG:
					showRandomBg();
					break;
				case HIDE_RANDOM_BG:
					hideRandomBg();
					break;
			}
		}
		
		private function showRandomBg(): void
		{
			GameManager.instance.addBase(_loader);
			var _index: int = Math.random() * 10 + 1;
			var _urlRequest: URLRequest = new URLRequest("resources/loader_bg/bg_" + _index + ".jpg");
			_loader.load(_urlRequest);
		}
		
		private function hideRandomBg(): void
		{
			stage.removeChild(_loader);
		}
		
		private function showProgressBar(): void
		{
			stage.addChild(component);
			UIUtils.center(component);
		}
		
		private function hideProgressBar(): void
		{
			stage.removeChild(component);
		}
		
		private function setProgressBarTitle(value: String): void
		{
			component.title = value;
		}
		
		private function setProgressBarPercent(value: Number): void
		{
			component.percentage = value;
		}
		
		private function setZero(): void
		{
			component.percentage = 0;
		}
		
		protected function get stage(): StageMediator
		{
			return facade.retrieveMediator(StageMediator.NAME) as StageMediator;
		}
		
		protected function get component(): LoaderProgressBarComponent
		{
			return viewComponent as LoaderProgressBarComponent;
		}
	}
}