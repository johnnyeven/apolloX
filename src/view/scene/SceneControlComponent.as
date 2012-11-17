package view.scene
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.utils.getDefinitionByName;
	
	import utils.liteui.core.Component;
	import utils.liteui.component.MessageBox;
	
	public class SceneControlComponent extends Component
	{
		private var _topContainer: SceneControlTopComponent;
		private var _promptContainer: MovieClip;
		private var _menuContainer: MovieClip;
		private var _messageContainer: MovieClip;
		
		public function SceneControlComponent()
		{
			var _class: Class = getDefinitionByName("ui.core.ControlPanelSkin") as Class;
			var _skin: MovieClip = new _class() as MovieClip;
			
			super(_skin);
			
			_topContainer = getUI(SceneControlTopComponent, "topContainer") as SceneControlTopComponent;
			_promptContainer = _skin.getChildByName("promptContainer") as MovieClip;
			_menuContainer = _skin.getChildByName("menuContainer") as MovieClip;
			_messageContainer = _skin.getChildByName("messageContainer") as MovieClip;
			
			sortChildIndex();
		}
	}
}