package view.scene.station.ensure
{
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	import mediator.scene.station.EnsureSelectViewMediator;
	
	import parameters.station.EnsureSelectItemListParameter;
	
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
		private var _btnConfirm: Button;
		private var _btnClose: Button;
		private var _caption: Label;
		private var _lblNameLabel: Label;
		private var _lblCostLabel: Label;
		private var _container: Container;
		private var _scrollBar: ScrollBar;
		
		public function EnsureSelectViewComponent()
		{
			super(ResourcePool.getResource("assets.scene1Station.ensure.selectView") as DisplayObjectContainer);
			
			_btnConfirm = getUI(Button, "btnConfirm") as Button;
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
			var parameter: EnsureSelectItemListParameter = new EnsureSelectItemListParameter();
			parameter.ensureName = "基础级保险";
			parameter.money = 25102;
			parameter.cost = 0;
			var item: EnsureSelectListItemComponent = new EnsureSelectListItemComponent();
			item.info = parameter;
			_container.add(item);
			item.addEventListener(MouseEvent.CLICK, onItemClick);
			
			parameter = new EnsureSelectItemListParameter();
			parameter.ensureName = "青铜级保险";
			parameter.money = 105033;
			parameter.cost = 10000;
			parameter.isCurrent = true;
			item = new EnsureSelectListItemComponent();
			item.info = parameter;
			_container.add(item);
			item.addEventListener(MouseEvent.CLICK, onItemClick);
			
			parameter = new EnsureSelectItemListParameter();
			parameter.ensureName = "白银级保险";
			parameter.money = 508790;
			parameter.cost = 50000;
			item = new EnsureSelectListItemComponent();
			item.info = parameter;
			_container.add(item);
			item.addEventListener(MouseEvent.CLICK, onItemClick);
			
			_container.layout.update();
			_scrollBar.rebuild();
		}
		
		private function onItemClick(evt: MouseEvent): void
		{
			for(var i: int = 0; i<_container.childrenNum; i++)
			{
				var item: EnsureSelectListItemComponent = _container.getAt(i) as EnsureSelectListItemComponent;
				item.hideHighlight();
			}
			var _this: EnsureSelectListItemComponent = evt.target as EnsureSelectListItemComponent;
			_this.showHighlight();
		}
	}
}