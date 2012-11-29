package view.scene.station.repair
{
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	import mediator.scene.station.RepairViewMediator;
	
	import utils.liteui.component.Button;
	import utils.liteui.component.Label;
	import utils.liteui.core.Component;
	import utils.resource.ResourcePool;
	
	public class RepairViewComponent extends Component
	{
		private var _btnClose: Button;
		private var _caption: Label;
		private var _lblShipNameLabel: Label;
		private var _lblDamageLabel: Label;
		private var _lblRepairCostLabel: Label;
		private var _lblControlLabel: Label;
		
		public function RepairViewComponent()
		{
			super(ResourcePool.getResource("assets.scene1Station.repair.view") as DisplayObjectContainer);
			
			_btnClose = getUI(Button, "btnClose") as Button;
			_caption = getUI(Label, "caption") as Label;
			_lblShipNameLabel = getUI(Label, "lblShipName") as Label;
			_lblDamageLabel = getUI(Label, "lblDamage") as Label;
			_lblRepairCostLabel = getUI(Label, "lblRepairCost") as Label;
			_lblControlLabel = getUI(Label, "lblControl") as Label;
			
			sortChildIndex();
			
			_caption.text = "维修厂";
			_btnClose.addEventListener(MouseEvent.CLICK, onBtnCloseClick);
		}
		
		private function onBtnCloseClick(evt: MouseEvent): void
		{
			ApplicationFacade.getInstance().sendNotification(RepairViewMediator.REPAIR_DISPOSE_NOTE);
		}
		
		public function showSlotComponent(): void
		{
			
		}
	}
}