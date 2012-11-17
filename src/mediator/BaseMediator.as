package mediator
{
	import flash.display.DisplayObject;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import utils.GameManager;
	import utils.PopUpManager;
	import utils.liteui.core.Component;
	
	public class BaseMediator extends Mediator implements IMediator
	{
		protected var _isPopUp: Boolean = false;
		public var mode: Boolean = false;
		public var onShow: Function;
		public var onDestroy: Function;
		public var zIndex: int;
		public var width: Number;
		public var height: Number;
		
		public function BaseMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
		}
		
		public function get comp(): DisplayObject
		{
			return viewComponent as DisplayObject;
		}
		
		public function isShow(): Boolean
		{
			return comp.stage == null ? false : true;
		}
		
		public function show(): void
		{
			if(isShow())
			{
				return;
			}
			addComponent();
		}
		
		public function dispose(): void
		{
			if(viewComponent != null)
			{
				if(_isPopUp)
				{
					
				}
				else
				{
					if(comp is Component)
					{
						(comp as Component).dispose();
					}
					viewComponent = null;
				}
			}
			facade.removeMediator(getMediatorName());
			callDestroyCallback();
		}
		
		private function callDestroyCallback(): void
		{
			if(onDestroy != null)
			{
				onDestroy();
			}
			onDestroy = null;
		}
		
		protected function addComponent(): void
		{
			if(_isPopUp)
			{
				PopUpManager.closeAll(zIndex);
				PopUpManager.addPopUp(comp, mode);
			}
			else
			{
				GameManager.instance.addBase(comp);
			}
		}
	}
}