package view.scene.station.assembly
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Strong;
	
	import fl.motion.ColorMatrix;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	
	import utils.MenuManager;
	import utils.liteui.component.ImageContainer;
	import utils.liteui.component.Menu;
	import utils.liteui.component.MenuItem;
	import utils.liteui.core.Component;
	import utils.liteui.layouts.Margin;
	
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
			
			addEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		private function onMouseClick(evt: MouseEvent): void
		{
			var _menu: Menu = new Menu();
			_menu.x = evt.stageX;
			_menu.y = evt.stageY;
			_menu.padding = new Margin(20, 20, 20, 20);
			
			var _item1: MenuItem = new MenuItem();
			_item1.itemName = "lock";
			_item1.text = "锁定";
			
			var _item2: MenuItem = new MenuItem();
			_item2.itemName = "approach";
			_item2.text = "接近目标";
			
			var _item3: MenuItem = new MenuItem();
			_item3.itemName = "password";
			_item3.text = "输入母星立场密码";
			
			_menu.addItem(_item1);
			_menu.addItem(_item2);
			_menu.addItem(_item3);
			
			MenuManager.showMenu(_menu);
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