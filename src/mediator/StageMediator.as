package mediator
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class StageMediator extends Mediator implements IMediator
	{
		public static const NAME: String = "StageMediator";
		
		public function StageMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		public function get component(): Main
		{
			return viewComponent as Main;
		}
		
		public function get stage(): Stage
		{
			return component.stage;
		}
		
		public function addChild(value: DisplayObject): void
		{
			component.addChild(value);
		}
		
		public function removeChild(value: DisplayObject): void
		{
			component.removeChild(value);
		}
	}
}