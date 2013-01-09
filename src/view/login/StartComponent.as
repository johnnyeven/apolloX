package view.login
{
	import com.greensock.TweenLite;
	
	import events.LoginEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	import utils.liteui.component.Button;
	import utils.liteui.core.Component;
	import utils.resource.ResourcePool;
	
	public class StartComponent extends Component
	{
		private var _topDoorMC: Component;
		private var _bottomDoorMC: Component;
		
		private var _buttonStart: Button;
		private var _buttonLogin: Button;
		private var _buttonRegister: Button;
		
		public function StartComponent()
		{
			super(ResourcePool.getResource("ui.login.StartWindowSkin") as DisplayObjectContainer);
			
			_topDoorMC = getUI(Component, "topDoorMC") as Component;
			_bottomDoorMC = getUI(Component, "bottomDoorMC") as Component;
			
			_buttonStart = _topDoorMC.getUI(Button, "btnStart") as Button;
			_buttonLogin = _bottomDoorMC.getUI(Button, "btnLogin") as Button;
			_buttonRegister = _bottomDoorMC.getUI(Button, "btnRegister") as Button;
			
			_topDoorMC.sortChildIndex();
			_bottomDoorMC.sortChildIndex();
			sortChildIndex();
			
			_buttonStart.addEventListener(MouseEvent.CLICK, onButtonStartClick);
			_buttonLogin.addEventListener(MouseEvent.CLICK, onButtonLoginClick);
			_buttonRegister.addEventListener(MouseEvent.CLICK, onButtonRegisterClick);
		}
		
		private function onButtonStartClick(evt: MouseEvent): void
		{
			var _evt: LoginEvent = new LoginEvent(LoginEvent.START_EVENT);
			dispatchEvent(_evt);
		}
		
		private function onButtonLoginClick(evt: MouseEvent): void
		{
			var _evt: LoginEvent = new LoginEvent(LoginEvent.ACCOUNT_EVENT);
			dispatchEvent(_evt);
		}
		
		private function onButtonRegisterClick(evt: MouseEvent): void
		{
			var _evt: LoginEvent = new LoginEvent(LoginEvent.ACCOUNT_EVENT);
			dispatchEvent(_evt);
		}
		
		public function closeDoor(callback: Function = null): void
		{
			TweenLite.to(_topDoorMC, .5, {
				y: 0
			});
			TweenLite.to(_bottomDoorMC, .5, {
				y: 291.6,
				onComplete: callback
			});
		}
		
		public function openDoor(callback: Function = null): void
		{
			TweenLite.to(_topDoorMC, .5, {
				y: -_topDoorMC.height
			});
			TweenLite.to(_bottomDoorMC, .5, {
				y: stage.stageHeight,
				onComplete: callback
			});
		}
		
		public function switchDoorStatus(opened: Boolean): void
		{
			if(opened)
			{
				_topDoorMC.y = -_topDoorMC.height;
				_bottomDoorMC.y = stage.stageHeight;
			}
			else
			{
				_topDoorMC.y = 0;
				_bottomDoorMC.y = 291.6;
			}
		}
	}
}