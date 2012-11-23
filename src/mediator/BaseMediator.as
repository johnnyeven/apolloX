package mediator
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Strong;
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
					switch(popUpEffect)
					{
						case PopupEffect.TOP:
							TweenLite.to(comp, .5, {y: -comp.height, ease: Strong.easeIn, onComplete: onTweenDestroy});
							break;
						case PopupEffect.LEFT:
							TweenLite.to(comp, .5, {y: -comp.width, ease: Strong.easeIn, onComplete: onTweenDestroy});
							break;
						case PopupEffect.BOTTOM:
							TweenLite.to(comp, .5, {y: GameManager.container.stageHeight, ease: Strong.easeIn, onComplete: onTweenDestroy});
							break;
						case PopupEffect.RIGHT:
							TweenLite.to(comp, .5, {x: GameManager.container.stageWidth, ease: Strong.easeIn, onComplete: onTweenDestroy});
							break;
						case PopupEffect.CENTER:
							TweenLite.to(comp, .5, {transformAroundCenter: {scaleX: .5, scaleY: .5, alpha: .5}, ease: Strong.easeIn, onComplete: onTweenDestroy});
							break;
					}
				}
				else
				{
					if(comp is Component)
					{
						(comp as Component).dispose();
					}
					viewComponent = null;
					callDestroyCallback();
				}
			}
			else
			{
				callDestroyCallback();
			}
			
			if(comp is Component)
			{
				(comp as Component).removeChangeWatcher();
			}
			facade.removeMediator(getMediatorName());
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
						
						TweenLite.to(comp, 0.5, {y: centerPoint.y, ease: Strong.easeOut, onComplete: onShowComplete});
						break;
					case PopupEffect.RIGHT:
						comp.x = GameManager.container.stageWidth;
						comp.y = 0;
						
						TweenLite.to(comp, 0.5, {x: comp.x - comp.width, ease: Strong.easeOut, onComplete: onShowComplete});
						break;
					case PopupEffect.LEFT:
						comp.x = -comp.width;
						comp.y = 0;
						
						TweenLite.to(comp, 0.5, {x: 0, ease: Strong.easeOut, onComplete: onShowComplete});
						break;
					case PopupEffect.BOTTOM:
						comp.y = GameManager.container.stageHeight;
						comp.x = centerPoint.x;
						
						TweenLite.to(comp, 0.5, {y: centerPoint.y, ease: Strong.easeOut, onComplete: onShowComplete});
						break;
					case PopupEffect.CENTER:
						comp.scaleX = .5;
						comp.scaleY = .5;
						comp.alpha = 0;
						centerPoint = UIUtils.componentCenterInStage(comp, width, height);
						comp.x = centerPoint.x;
						comp.y = centerPoint.y;
						
						TweenLite.to(comp, .5, { transformAroundCenter: { scaleX: 1, scaleY: 1, alpha: 1 }, ease: Strong.easeOut, onComplete: onShowComplete });
						break;
				}
			}
			else
			{
				GameManager.instance.addBase(comp);
				onShowComplete();
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
		
		public function onTweenDestroy(): void
		{
			PopUpManager.removePopUp(comp);
			
			if(comp is Component)
			{
				(comp as Component).dispose();
			}
			viewComponent = null;
			callDestroyCallback();
		}
	}
}