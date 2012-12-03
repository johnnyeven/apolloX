package view.scene.station.medical
{
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	import mediator.scene.station.MedicalViewMediator;
	
	import parameters.station.MedicalItemListParameter;
	
	import utils.enum.ScrollBarOrientation;
	import utils.liteui.component.Button;
	import utils.liteui.component.Container;
	import utils.liteui.component.Label;
	import utils.liteui.component.ScrollBar;
	import utils.liteui.core.Component;
	import utils.liteui.layouts.HorizontalTileLayout;
	import utils.resource.ResourcePool;
	
	import view.scene.station.medical.MedicalListItemComponent;
	
	public class MedicalViewComponent extends Component
	{
		private var _btnClose: Button;
		private var _caption: Label;
		private var _lblCloneNameLabel: Label;
		private var _lblSkillPointLabel: Label;
		private var _lblCostLabel: Label;
		private var _lblControlLabel: Label;
		private var _container: Container;
		private var _scrollBar: ScrollBar;
		
		public function MedicalViewComponent()
		{
			super(ResourcePool.getResource("assets.scene1Station.medical.view") as DisplayObjectContainer);
			
			_btnClose = getUI(Button, "btnClose") as Button;
			_caption = getUI(Label, "caption") as Label;
			_lblCloneNameLabel = getUI(Label, "lblCloneName") as Label;
			_lblSkillPointLabel = getUI(Label, "lblSkillPoint") as Label;
			_lblCostLabel = getUI(Label, "lblCost") as Label;
			_lblControlLabel = getUI(Label, "lblControl") as Label;
			
			_container = new Container();
			_container.x = 23;
			_container.y = 100;
			_container.contentWidth = 659;
			_container.contentHeight = 332;
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
			ApplicationFacade.getInstance().sendNotification(MedicalViewMediator.MEDICAL_DISPOSE_NOTE);
		}
		
		public function showListComponent(): void
		{
			var parameter: MedicalItemListParameter = new MedicalItemListParameter();
			parameter.avatar = "resources/assets/hallofhonor_image_kind2_1.png";
			parameter.cloneName = "基础级克隆（A级）";
			parameter.skillPoint = 200000;
			parameter.cost = 0;
			parameter.isCurrent = true;
			var item: MedicalListItemComponent = new MedicalListItemComponent();
			item.info = parameter;
			_container.add(item);
			
			parameter = new MedicalItemListParameter();
			parameter.avatar = "resources/assets/hallofhonor_image_kind2_2.png";
			parameter.cloneName = "启航级克隆（B级）";
			parameter.skillPoint = 500000;
			parameter.cost = 10000;
			item = new MedicalListItemComponent();
			item.info = parameter;
			_container.add(item);
			
			parameter = new MedicalItemListParameter();
			parameter.avatar = "resources/assets/hallofhonor_image_kind2_3.png";
			parameter.cloneName = "远洋级克隆（C级）";
			parameter.skillPoint = 1000000;
			parameter.cost = 20000;
			item = new MedicalListItemComponent();
			item.info = parameter;
			_container.add(item);
			
			parameter = new MedicalItemListParameter();
			parameter.avatar = "resources/assets/hallofhonor_image_kind2_4.png";
			parameter.cloneName = "冲锋级克隆（D级）";
			parameter.skillPoint = 2500000;
			parameter.cost = 50000;
			item = new MedicalListItemComponent();
			item.info = parameter;
			_container.add(item);
			
			parameter = new MedicalItemListParameter();
			parameter.avatar = "resources/assets/hallofhonor_image_kind2_5.png";
			parameter.cloneName = "突击级克隆（E级）";
			parameter.skillPoint = 5000000;
			parameter.cost = 100000;
			item = new MedicalListItemComponent();
			item.info = parameter;
			_container.add(item);
			
			parameter = new MedicalItemListParameter();
			parameter.avatar = "resources/assets/hallofhonor_image_kind2_6.png";
			parameter.cloneName = "扫荡级克隆（F级）";
			parameter.skillPoint = 7500000;
			parameter.cost = 150000;
			item = new MedicalListItemComponent();
			item.info = parameter;
			_container.add(item);
			
			parameter = new MedicalItemListParameter();
			parameter.avatar = "resources/assets/hallofhonor_image_kind2_7.png";
			parameter.cloneName = "决战级克隆（G级）";
			parameter.skillPoint = 10000000;
			parameter.cost = 200000;
			item = new MedicalListItemComponent();
			item.info = parameter;
			_container.add(item);
			
			parameter = new MedicalItemListParameter();
			parameter.avatar = "resources/assets/hallofhonor_image_kind2_8.png";
			parameter.cloneName = "狂战级克隆（H级）";
			parameter.skillPoint = 20000000;
			parameter.cost = 400000;
			item = new MedicalListItemComponent();
			item.info = parameter;
			_container.add(item);
			
			parameter = new MedicalItemListParameter();
			parameter.avatar = "resources/assets/hallofhonor_image_kind2_9.png";
			parameter.cloneName = "圣战级克隆（I级）";
			parameter.skillPoint = 40000000;
			parameter.cost = 800000;
			item = new MedicalListItemComponent();
			item.info = parameter;
			_container.add(item);
			
			_container.layout.update();
			_scrollBar.rebuild();
		}
	}
}