package view.scene.station.assembly
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Strong;
	
	import fl.motion.ColorMatrix;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	
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
		
		override protected function onMouseOver(evt:MouseEvent):void
		{
			TweenLite.to(this, .3, {transformAroundCenter: {scaleX: 1.1, scaleY: 1.1}, ease: Strong.easeOut});
		}
		
		override protected function onMouseOut(evt:MouseEvent):void
		{
			TweenLite.to(this, .3, {transformAroundCenter: {scaleX: 1, scaleY: 1}, ease: Strong.easeOut});
		}
	}
}