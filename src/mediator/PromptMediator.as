package mediator
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import com.greensock.TweenLite;
	
	import view.PromptComponent;
	import utils.UIUtils;
	
	public class PromptMediator extends Mediator implements IMediator
	{
		public static const NAME: String = "PromptMediator";
		private var _loadingMovieClip: MovieClip;
		
		/**
		 * 消息定义
		 */
		public static const PROMPT_SHOW_NOTE: String = "prompt_show_note";
		public static const PROMPT_HIDE_NOTE: String = "prompt_hide_note";
		public static const LOADING_SHOW_NOTE: String = "loading_show_note";
		public static const LOADING_HIDE_NOTE: String = "loading_hide_note";
		
		public function PromptMediator(viewComponent:Object=null)
		{
			viewComponent = viewComponent == null ? new PromptComponent() : viewComponent;
			super(NAME, viewComponent);
			
			var _class: Class = getDefinitionByName("ui.LoadingIconSkin") as Class;
			_loadingMovieClip = new _class() as MovieClip;
		}
		
		override public function listNotificationInterests(): Array
		{
			return [PROMPT_SHOW_NOTE, PROMPT_HIDE_NOTE,
				LOADING_SHOW_NOTE, LOADING_HIDE_NOTE];
		}
		
		override public function handleNotification(notification:INotification): void
		{
			switch(notification.getName())
			{
				case PROMPT_SHOW_NOTE:
					showPrompt(notification.getBody() as String);
					break;
				case PROMPT_HIDE_NOTE:
					hidePrompt();
					break;
				case LOADING_SHOW_NOTE:
					showLoading();
					break;
				case LOADING_HIDE_NOTE:
					hideLoading();
					break;
			}
		}
		
		private function showPrompt(value: String): void
		{
			component.title = value;
			UIUtils.center(component);
			var _stageMediator: StageMediator = (facade.retrieveMediator(StageMediator.NAME)) as StageMediator;
			_stageMediator.addChild(component);
		}
		
		private function hidePrompt(): void
		{
			var _stageMediator: StageMediator = (facade.retrieveMediator(StageMediator.NAME)) as StageMediator;
			_stageMediator.removeChild(component);
		}
		
		private function showLoading(): void
		{
			var _stageMediator: StageMediator = (facade.retrieveMediator(StageMediator.NAME)) as StageMediator;
			_loadingMovieClip.alpha = 0;
			UIUtils.center(_loadingMovieClip);
			_stageMediator.addChild(_loadingMovieClip);
			TweenLite.to(_loadingMovieClip, .5, {
				alpha: 1
			});
		}
		
		private function hideLoading(): void
		{
			var _stageMediator: StageMediator = (facade.retrieveMediator(StageMediator.NAME)) as StageMediator;
			_loadingMovieClip.alpha = 1;
			TweenLite.to(_loadingMovieClip, .5, {
				alpha: 0,
				onComplete: function(): void {
					_stageMediator.removeChild(_loadingMovieClip);
				}
			});
		}
		
		private function get component(): PromptComponent
		{
			return viewComponent as PromptComponent;
		}
	}
}