package view.render
{
	import enum.EnumAction;
	
	import flash.display.MovieClip;
	import flash.errors.IllegalOperationError;
	
	import view.space.effects.rocket.EffectRocketComponent;

	public class RocketRender extends AutoDirectRender
	{
		public function RocketRender()
		{
			super();
		}
		
		override public function rendering(force:Boolean=false):void
		{
			if(_target is EffectRocketComponent)
			{
				var _targetComponent: EffectRocketComponent = _target as EffectRocketComponent;
				if(_targetComponent.action == EnumAction.EXPLODE)
				{
					var _explodeEffect: MovieClip = _targetComponent.explodeEffect;
					if(_explodeEffect.currentFrame >= _explodeEffect.totalFrames)
					{
						_targetComponent.dispose();
						return;
					}
				}
				super.rendering(force);
			}
			else
			{
				throw new IllegalOperationError("AutoDirectRender must use in a MovableComponent");
			}
		}
	}
}