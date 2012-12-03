package controller.scene
{
	import flash.display.DisplayObject;
	
	import mediator.scene.station.EnsureViewMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import utils.resource.ResourcePool;
	
	public class CreateEnsureViewCommand extends SimpleCommand
	{
		public static const LOAD_ENSURE_VIEW_NOTE: String = "LoadSureViewNote";
		
		public function CreateEnsureViewCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var _mediator: EnsureViewMediator = facade.retrieveMediator(EnsureViewMediator.NAME) as EnsureViewMediator;
			if (_mediator != null)
			{
				_mediator.show();
			}
			else
			{
				ResourcePool.getResourceByLoader("station_ensure_ui", "assets.scene1Station.ensure.view", onLoadComplete);
			}
		}
		
		private function onLoadComplete(target: DisplayObject): void
		{
			var _mediator: EnsureViewMediator = new EnsureViewMediator();
			facade.registerMediator(_mediator);
			
			_mediator.show();
		}
	}
}