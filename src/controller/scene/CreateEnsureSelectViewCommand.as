package controller.scene
{
	import flash.display.DisplayObject;
	
	import mediator.scene.station.EnsureSelectViewMediator;
	import mediator.scene.station.EnsureViewMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import utils.resource.ResourcePool;
	
	public class CreateEnsureSelectViewCommand extends SimpleCommand
	{
		public static const LOAD_ENSURE_VIEW_NOTE: String = "LoadSureSelectViewNote";
		
		public function CreateEnsureSelectViewCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var _mediator: EnsureSelectViewMediator = facade.retrieveMediator(EnsureSelectViewMediator.NAME) as EnsureSelectViewMediator;
			if (_mediator != null)
			{
				_mediator.show();
			}
			else
			{
				ResourcePool.getResourceByLoader("station_ensure_ui", "assets.scene1Station.ensure.selectView", onLoadComplete);
			}
		}
		
		private function onLoadComplete(target: DisplayObject): void
		{
			var _mediator: EnsureSelectViewMediator = new EnsureSelectViewMediator();
			facade.registerMediator(_mediator);
			
			_mediator.show();
		}
	}
}