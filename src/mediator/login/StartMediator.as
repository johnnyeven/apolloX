package mediator.login
{
	import events.LoginEvent;
	
	import mediator.StageMediator;
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	
	import proxy.LoginProxy;
	
	import view.login.LoginBGComponent;
	import view.login.StartComponent;
	
	import utils.GameManager;
	
	public class StartMediator extends BaseMediator
	{
		public static const NAME: String = "LoginMediator";
		
		public static const DESTROY_NOTE: String = "Destroy" + NAME;
		
		public function StartMediator(viewComponent:Object=null)
		{
			super(NAME, new StartComponent());
			
			component.addEventListener(LoginEvent.START_EVENT, onLoginStart);
			component.addEventListener(LoginEvent.ACCOUNT_EVENT, onLoginAccount);
		}
		
		override public function listNotificationInterests():Array
		{
			return [DESTROY_NOTE];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case DESTROY_NOTE:
					dispose();
					break;
			}
		}
		
		public function addBg(): void
		{
			GameManager.instance.addBack(LoginBGComponent.getInstance());
			LoginBGComponent.getInstance().show();
		}
		
		public function removeBg(): void
		{
			GameManager.instance.removeBack(LoginBGComponent.getInstance());
//			LoginBGComponent.getInstance().hide(function(): void
//			{
//				GameManager.instance.removeBase(LoginBGComponent.getInstance());
//			});
		}
		
		private function onLoginStart(evt: LoginEvent): void
		{
			component.switchDoorStatus(false);
			component.openDoor(startHandler);
		}
		
		private function onLoginAccount(evt: LoginEvent): void
		{
			component.switchDoorStatus(false);
			component.openDoor(accountHandler);
		}
		
		private function startHandler(): void
		{
			var _loginProxy: LoginProxy = facade.retrieveProxy(LoginProxy.NAME) as LoginProxy;
			_loginProxy.quickStart();
			dispose();
		}
		
		private function accountHandler(): void
		{
			
		}
		
		public function get component(): StartComponent
		{
			return viewComponent as StartComponent;
		}
		
		override public function show(): void
		{
			super.show();
			component.switchDoorStatus(true);
			component.closeDoor();
		}
		
		override public function dispose(): void
		{
			super.dispose();
			removeBg();
			LoginBGComponent.getInstance().destroy();
		}
	}
}