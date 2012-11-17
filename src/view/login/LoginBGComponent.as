package view.login
{
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	import flash.utils.getDefinitionByName;
	
	public class LoginBGComponent extends Sprite
	{
		private static var _instance: LoginBGComponent;
		private static var _allowInstance: Boolean = false;
		
		public function LoginBGComponent()
		{
			if(_allowInstance)
			{
				super();
				var _class: Class = getDefinitionByName("ui.login.LoginBG") as Class;
				var _skin: Sprite = new _class();
				addChild(_skin);
			}
			else
			{
				throw new IllegalOperationError("禁止实例化LoginBGComponent组件");
			}
		}
		
		public static function getInstance(): LoginBGComponent
		{
			if(_instance == null)
			{
				_allowInstance = true;
				_instance = new LoginBGComponent();
				_allowInstance = false;
			}
			return _instance;
		}
		
		public function show(callback: Function = null): void
		{
			TweenLite.from(this, 1, {
				alpha: 0,
				onComplete: callback
			});
		}
		
		public function hide(callback: Function = null): void
		{
			TweenLite.to(this, 1, {
				alpha: 0,
				onComplete: callback
			});
		}
		
		public function destroy(): void
		{
			if(this.alpha == 0 || this.visible == false)
			{
				dispose();
			}
			else
			{
				TweenLite.to(this, 1, {
					alpha: 0,
					onComplete: dispose
				});
			}
		}
		
		private function dispose(): void
		{
			delete(this);
		}
	}
}