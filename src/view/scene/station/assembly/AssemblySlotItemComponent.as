package view.scene.station.assembly
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	
	import utils.liteui.component.ImageContainer;
	import utils.liteui.core.Component;
	
	public class AssemblySlotItemComponent extends Component
	{
		private var _mc: MovieClip;
		private var _img: ImageContainer;
		
		public function AssemblySlotItemComponent(_skin:DisplayObjectContainer=null)
		{
			super(_skin);
			
			_mc = getSkin("mc") as MovieClip;
			_img = getUI(ImageContainer, "img") as ImageContainer;
			
			sortChildIndex();
		}
	}
}