package controller.space.effects
{
	import mediator.space.effects.EffectRocketMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import parameters.space.RocketLuanchParameter;
	import parameters.space.RocketRegisterParameter;
	
	import utils.events.LoaderEvent;
	import utils.loader.ResourceLoadManager;
	import utils.loader.XMLLoader;
	
	public class CreateRocketEffectsCommand extends SimpleCommand
	{
		public static const FIRE_NOTE: String = "CreateRocketEffectsCommand.FireNote";
		
		public function CreateRocketEffectsCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			switch(notification.getName())
			{
				case FIRE_NOTE:
					if(!facade.hasMediator(EffectRocketMediator.NAME))
					{
						facade.registerMediator(new EffectRocketMediator());
					}
					sendNotification(EffectRocketMediator.SHOW_NOTE, notification.getBody());
					break;
			}
		}
	}
}