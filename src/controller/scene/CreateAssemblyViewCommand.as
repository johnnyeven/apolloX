package controller.scene
{
	import flash.display.DisplayObject;
	
	import mediator.scene.station.AssemblyViewMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import utils.resource.ResourcePool;
	
	public class CreateAssemblyViewCommand extends SimpleCommand
	{
		public static const LOAD_ASSEMBLY_VIEW_NOTE: String = "LoadAssemblyViewNote";
		
		public function CreateAssemblyViewCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var _mediator: AssemblyViewMediator = facade.retrieveMediator(AssemblyViewMediator.NAME) as AssemblyViewMediator;
			if (_mediator != null)
			{
				facade.sendNotification(AssemblyViewMediator.ASSEMBLY_SHOW_NOTE);
			}
			else
			{
				ResourcePool.getResourceByLoader("station_assembly_ui", "assets.scene1Station.assembly.view", onLoadComplete);
			}
		}
		
		private function onLoadComplete(target: DisplayObject): void
		{
			facade.registerMediator(new AssemblyViewMediator());
			
			facade.sendNotification(AssemblyViewMediator.ASSEMBLY_SHOW_NOTE);
		}
	}
}