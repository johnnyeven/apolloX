package mediator.space.effects
{
	import mediator.BaseMediator;
	import mediator.space.SpaceSceneMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	
	import parameters.space.RocketRegisterParameter;
	
	import view.control.RocketController;
	import view.render.AutoDirectRender;
	import view.space.effects.rocket.EffectRocketComponent;
	
	public class EffectRocketMediator extends BaseMediator
	{
		public static const NAME: String = "EffectRocketMediator";
		public static const SHOW_NOTE: String = "EffectRocketMediator.ShowNote";
		
		public function EffectRocketMediator()
		{
			super(NAME, null);
		}
		
		public function get component(): EffectRocketComponent
		{
			return viewComponent as EffectRocketComponent;
		}
		
		override public function listNotificationInterests():Array
		{
			return [SHOW_NOTE];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case SHOW_NOTE:
					//var parameter: RocketRegisterParameter = notification.getBody() as RocketRegisterParameter;
					var rocket: EffectRocketComponent = new EffectRocketComponent(notification.getBody() as RocketRegisterParameter);
					rocket.controller = new RocketController();
					rocket.render = new AutoDirectRender();
					rocket.mediator = this;
					
					viewComponent = rocket;
					show();
					break;
			}
		}
		
		override public function show():void
		{
			var _mediator: SpaceSceneMediator = facade.retrieveMediator(SpaceSceneMediator.NAME) as SpaceSceneMediator;
			_mediator.addObject(component);
			trace("added");
			onShowComplete();
		}
	}
}