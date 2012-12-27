package mediator.space.effects
{
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class EffectRocketMediator extends Mediator implements IMediator
	{
		public static const NAME: String = "EffectRocketMediator";
		
		public function EffectRocketMediator()
		{
			super(NAME, null);
		}
	}
}