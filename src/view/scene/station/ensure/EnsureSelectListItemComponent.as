package view.scene.station.ensure
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import mediator.scene.station.EnsureSelectViewMediator;
	
	import parameters.station.EnsureSelectItemListParameter;
	
	import utils.language.LanguageManager;
	import utils.liteui.component.Label;
	import utils.liteui.core.Component;
	import utils.resource.ResourcePool;
	
	import view.scene.station.ensure.EnsureListItemComponent;
	
	public class EnsureSelectListItemComponent extends Component
	{
		private var _lblEnsureName: Label;
		private var _lblMoney: Label;
		private var _lblCost: Label;
		private var _highlight: MovieClip;
		private var _info: EnsureSelectItemListParameter;
		
		public function EnsureSelectListItemComponent()
		{
			super(ResourcePool.getResource("assets.scene1Station.ensure.selectViewList") as DisplayObjectContainer);
			
			_lblEnsureName = getUI(Label, "ensureName") as Label;
			_lblMoney = getUI(Label, "money") as Label;
			_lblCost = getUI(Label, "cost") as Label;
			_highlight = getSkin("highlight") as MovieClip;
			
			sortChildIndex();
			
			_highlight.visible = false;
		}
		
		public function showHighlight(): void
		{
			_highlight.visible = true;
		}
		
		public function hideHighlight(): void
		{
			_highlight.visible = false;
		}

		public function get info():EnsureSelectItemListParameter
		{
			return _info;
		}

		public function set info(value:EnsureSelectItemListParameter):void
		{
			if(value != null)
			{
				_info = value;
				
				if(value.isCurrent)
				{
					_lblEnsureName.text = value.ensureName + " (" + LanguageManager.getInstance().lang("ensure_current") + ")";
				}
				_lblMoney.text = value.money.toString() + " ISK";
				if(value.cost > 0)
				{
					_lblCost.text = value.cost + " ISK";
				}
				else
				{
					_lblCost.text = LanguageManager.getInstance().lang("ensure_cost_free");
				}
			}
		}

	}
}