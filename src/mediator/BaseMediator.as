package mediator
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	import com.greensock.plugins.TransformAroundCenterPlugin;
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import utils.GameManager;
	import utils.PopUpManager;
	import utils.UIUtils;
	import utils.enum.PopupEffect;
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
		public var popUpEffect: int = PopupEffect.TOP;
		
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
				
				var centerPoint: Point = UIUtils.componentCenterInStage(comp, width, height);
				switch(popUpEffect)
				{
					case PopupEffect.TOP:
						comp.y = -comp.height;
						comp.x = centerPoint.x;
						
						TweenLite.to(comp, 0.5, {y: centerPoint.y, onComplete: onShowComplete});
						break;
					case PopupEffect.RIGHT:
						comp.x = GameManager.container.stageWidth;
						comp.y = 0;
						
						TweenLite.to(comp, 0.5, {x: comp.x - comp.width, onComplete: onShowComplete});
						break;
					case PopupEffect.LEFT:
						comp.x = -comp.width;
						comp.y = 0;
						
						TweenLite.to(comp, 0.5, {x: 0, onComplete: onShowComplete});
						break;
					case PopupEffect.BOTTOM:
						comp.y = GameManager.container.stageHeight;
						comp.x = centerPoint.x;
						
						TweenLite.to(comp, 0.5, {y: centerPoint.y, onComplete: onShowComplete});
						break;
					case PopupEffect.CENTER:
						comp.scaleX = .5;
						comp.scaleY = .5;
						comp.alpha = 0;
						comp.x = centerPoint.x;
						comp.y = centerPoint.y;
						
						TweenLite.to(comp, .5, { transformAroundCenter: { scaleX: 1, scaleY: 1, alpha: 1 }, ease: Linear.easeIn, onComplete: onShowComplete });
						break;
				}
			}
			else
			{
				GameManager.instance.addBase(comp);
			}
		}
		
		public function onShowComplete(): void
		{
			if(onShow != null)
			{
				onShow(this);
			}
			onShow = null;
		}
	}
}