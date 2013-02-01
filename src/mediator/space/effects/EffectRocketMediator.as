package mediator.space.effects
{
	import enum.EnumAction;
	
	import mediator.BaseMediator;
	import mediator.space.SpaceSceneMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	
	import parameters.space.RocketRegisterParameter;
	
	import view.control.RocketController;
	import view.render.RocketRender;
	import view.space.effects.rocket.EffectRocketComponent;
	
	public class EffectRocketMediator extends BaseMediator
	{
		public static const NAME: String = "EffectRocketMediator";
		public static const SHOW_NOTE: String = "EffectRocketMediator.ShowNote";
		public static const HIT_NOTE: String = "EffectRocketMediator.HitNote";
		public static const DISPOSE_NOTE: String = "EffectRocketMediator.DisposeNote";
		
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
			return [SHOW_NOTE, HIT_NOTE, DISPOSE_NOTE];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case SHOW_NOTE:
					//var parameter: RocketRegisterParameter = notification.getBody() as RocketRegisterParameter;
					var rocket: EffectRocketComponent = new EffectRocketComponent(notification.getBody() as RocketRegisterParameter);
					rocket.controller = new RocketController();
					rocket.render = new RocketRender();
					rocket.mediator = this;
					rocket.action = EnumAction.MOVE;
					
					viewComponent = rocket;
					show();
					break;
				case HIT_NOTE:
					//向服务器发送击中目标的消息
					//创建爆炸动画
					(notification.getBody() as EffectRocketComponent).explodePre();
					sendNotification(DISPOSE_NOTE, notification.getBody());
					break;
				case DISPOSE_NOTE:
					//播放爆炸特效，并释放
					(notification.getBody() as EffectRocketComponent).explode();
					break;
			}
		}
		
		override public function show():void
		{
			var _mediator: SpaceSceneMediator = facade.retrieveMediator(SpaceSceneMediator.NAME) as SpaceSceneMediator;
			_mediator.addObject(component);
			onShowComplete();
		}
	}
}