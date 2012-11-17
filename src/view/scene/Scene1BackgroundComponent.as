package view.scene
{
	import events.SceneEvent;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.getDefinitionByName;
	
	public class Scene1BackgroundComponent extends Sprite
	{
		private var _tritiumGround: MovieClip;
		private var _baseGround: MovieClip;
		private var _timeMachineGround: MovieClip;
		private var _powerGround: MovieClip;
		private var _packageGround: MovieClip;
		private var _crystalGround: MovieClip;
		private var _scienceGround: MovieClip;
		private var _factoryGround: MovieClip;
		
		public function Scene1BackgroundComponent()
		{
			super();
			
			var _class: Class = getDefinitionByName("ui.scene1.BackgroundSkin") as Class;
			var _skin: MovieClip = new _class() as MovieClip;
			addChild(_skin);
			
			_tritiumGround = _skin.getChildByName("tritiumGround") as MovieClip;
			_baseGround = _skin.getChildByName("baseGround") as MovieClip;
			_timeMachineGround = _skin.getChildByName("timeMachineGround") as MovieClip;
			_powerGround = _skin.getChildByName("powerGround") as MovieClip;
			_packageGround = _skin.getChildByName("packageGround") as MovieClip;
			_crystalGround = _skin.getChildByName("crystalGround") as MovieClip;
			_scienceGround = _skin.getChildByName("scienceGround") as MovieClip;
			_factoryGround = _skin.getChildByName("factoryGround") as MovieClip;
			
			_tritiumGround.addEventListener(MouseEvent.CLICK, onTritiumClick);
			_baseGround.addEventListener(MouseEvent.CLICK, onBaseClick);
			_timeMachineGround.addEventListener(MouseEvent.CLICK, onTimeClick);
			_powerGround.addEventListener(MouseEvent.CLICK, onPowerClick);
			_packageGround.addEventListener(MouseEvent.CLICK, onPackageClick);
			_crystalGround.addEventListener(MouseEvent.CLICK, onCrystalClick);
			_scienceGround.addEventListener(MouseEvent.CLICK, onScienceClick);
			_factoryGround.addEventListener(MouseEvent.CLICK, onFactoryClick);
		}
		
		private function onTritiumClick(evt: MouseEvent): void
		{
			var _event: SceneEvent = new SceneEvent(
				SceneEvent.TRITIUM_GROUND_CLICK,
				evt.bubbles,
				evt.cancelable,
				evt.localX,
				evt.localY,
				evt.relatedObject,
				evt.ctrlKey,
				evt.altKey,
				evt.shiftKey,
				evt.buttonDown,
				evt.delta
			);
			dispatchEvent(_event);
		}
		
		private function onBaseClick(evt: MouseEvent): void
		{
			var _event: SceneEvent = new SceneEvent(
				SceneEvent.BASE_GROUND_CLICK,
				evt.bubbles,
				evt.cancelable,
				evt.localX,
				evt.localY,
				evt.relatedObject,
				evt.ctrlKey,
				evt.altKey,
				evt.shiftKey,
				evt.buttonDown,
				evt.delta
			);
			dispatchEvent(_event);
		}
		
		private function onTimeClick(evt: MouseEvent): void
		{
			var _event: SceneEvent = new SceneEvent(
				SceneEvent.TIMEMACHINE_GROUND_CLICK,
				evt.bubbles,
				evt.cancelable,
				evt.localX,
				evt.localY,
				evt.relatedObject,
				evt.ctrlKey,
				evt.altKey,
				evt.shiftKey,
				evt.buttonDown,
				evt.delta
			);
			dispatchEvent(_event);
		}
		
		private function onPowerClick(evt: MouseEvent): void
		{
			var _event: SceneEvent = new SceneEvent(
				SceneEvent.POWER_GROUND_CLICK,
				evt.bubbles,
				evt.cancelable,
				evt.localX,
				evt.localY,
				evt.relatedObject,
				evt.ctrlKey,
				evt.altKey,
				evt.shiftKey,
				evt.buttonDown,
				evt.delta
			);
			dispatchEvent(_event);
		}
		
		private function onPackageClick(evt: MouseEvent): void
		{
			var _event: SceneEvent = new SceneEvent(
				SceneEvent.PACKAGE_GROUND_CLICK,
				evt.bubbles,
				evt.cancelable,
				evt.localX,
				evt.localY,
				evt.relatedObject,
				evt.ctrlKey,
				evt.altKey,
				evt.shiftKey,
				evt.buttonDown,
				evt.delta
			);
			dispatchEvent(_event);
		}
		
		private function onCrystalClick(evt: MouseEvent): void
		{
			var _event: SceneEvent = new SceneEvent(
				SceneEvent.CRYSTAL_GROUND_CLICK,
				evt.bubbles,
				evt.cancelable,
				evt.localX,
				evt.localY,
				evt.relatedObject,
				evt.ctrlKey,
				evt.altKey,
				evt.shiftKey,
				evt.buttonDown,
				evt.delta
			);
			dispatchEvent(_event);
		}
		
		private function onScienceClick(evt: MouseEvent): void
		{
			var _event: SceneEvent = new SceneEvent(
				SceneEvent.SCIENCE_GROUND_CLICK,
				evt.bubbles,
				evt.cancelable,
				evt.localX,
				evt.localY,
				evt.relatedObject,
				evt.ctrlKey,
				evt.altKey,
				evt.shiftKey,
				evt.buttonDown,
				evt.delta
			);
			dispatchEvent(_event);
		}
		
		private function onFactoryClick(evt: MouseEvent): void
		{
			var _event: SceneEvent = new SceneEvent(
				SceneEvent.FACTORY_GROUND_CLICK,
				evt.bubbles,
				evt.cancelable,
				evt.localX,
				evt.localY,
				evt.relatedObject,
				evt.ctrlKey,
				evt.altKey,
				evt.shiftKey,
				evt.buttonDown,
				evt.delta
			);
			dispatchEvent(_event);
		}
	}
}