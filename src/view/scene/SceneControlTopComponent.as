package view.scene
{
	import flash.display.DisplayObjectContainer;
	
	import utils.liteui.component.Label;
	import utils.liteui.core.Component;
	
	public class SceneControlTopComponent extends Component
	{
		public var lblNickName: Label;
		public var lblMilitaryRank: Label;
		public var lblPrestige: Label;
		public var lblResourceCrystal: Label;
		public var lblResourceTritium: Label;
		public var lblResourceDarkMatter: Label;
		public var lblResourceDarkCrystal: Label;
		
		public function SceneControlTopComponent(_skin:DisplayObjectContainer=null)
		{
			super(_skin);
			
			lblNickName = getUI(Label, "txtNickName") as Label;
			lblMilitaryRank = getUI(Label, "txtRank") as Label;
			lblPrestige = getUI(Label, "txtPrestige") as Label;
			lblResourceCrystal = getUI(Label, "txtCrystal") as Label;
			lblResourceTritium = getUI(Label, "txtTritium") as Label;
			lblResourceDarkMatter = getUI(Label, "txtDarkMatter") as Label;
			lblResourceDarkCrystal = getUI(Label, "txtDarkCrystal") as Label;
			
			sortChildIndex();
		}
	}
}