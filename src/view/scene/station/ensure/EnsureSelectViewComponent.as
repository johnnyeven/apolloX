package view.scene.station.ensure
{
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	import mediator.scene.station.EnsureSelectViewMediator;
	
	import utils.enum.ScrollBarOrientation;
	import utils.liteui.component.Button;
	import utils.liteui.component.Container;
	import utils.liteui.component.Label;
	import utils.liteui.component.ScrollBar;
	import utils.liteui.core.Component;
	import utils.liteui.layouts.HorizontalTileLayout;
	import utils.resource.ResourcePool;
	
	import view.scene.station.ensure.EnsureListItemComponent;
	
	public class EnsureSelectViewComponent extends Component
	{
		private var _btnClose: Button;
		private var _caption: Label;
		private var _lblNameLabel: Label;
		private var _lblCostLabel: Label;
		private var _container: Container;
		private var _scrollBar: ScrollBar;
		
		public function EnsureSelectViewComponent()
		{
			super(ResourcePool.getResource("assets.scene1Station.ensure.selectView") as DisplayObjectContainer);
			
			_btnClose = getUI(Button, "btnClose") as Button;
			_caption = getUI(Label, "caption") as Label;
			_lblNameLabel = getUI(Label, "lblName") as Label;
			_lblCostLabel = getUI(Label, "lblCost") as Label;
			
			_container = new Container();
			_container.x = 9;
			_container.y = 75;
			_container.contentWidth = 470;
			_container.contentHeight = 210;
			_container.layout = new HorizontalTileLayout(_container);
			addChild(_container);
			
			_scrollBar = getUI(ScrollBar, "scrollBar") as ScrollBar;
			_scrollBar.orientation = ScrollBarOrientation.VERTICAL;
			_scrollBar.view = _container;
			
			sortChildIndex();
			addChild(_scrollBar);
			
			_btnClose.addEventListener(MouseEvent.CLICK, onBtnCloseClick);
		}
		
		private function onBtnCloseClick(evt: MouseEvent): void
		{
			ApplicationFacade.getInstance().sendNotification(EnsureSelectViewMediator.ENSURE_DISPOSE_NOTE);
		}
		
		public function showListComponent(): void
		{
			_container.layout.update();
			_scrollBar.rebuild();
		}
	}
}