package controller.space.effects
{
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import utils.events.LoaderEvent;
	import utils.loader.ResourceLoadManager;
	import utils.loader.XMLLoader;
	
	public class CreateRocketEffectsCommand extends SimpleCommand
	{
		public static const INIT_NOTE: String = "CreateRocketEffectsCommand.InitNote";
		public static const SHOW_NOTE: String = "CreateRocketEffectsCommand.ShowNote";
		
		public function CreateRocketEffectsCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			switch(notification.getName())
			{
				case INIT_NOTE:
					init(int(notification.getBody()));
					break;
				case SHOW_NOTE:
					trace("fire: " + notification.getBody());
					break;
			}
		}
		
		private function init(resourceId: int): void
		{
			ResourceLoadManager.load("resources/rocket/xml/rocket" + resourceId + ".xml", false, "", onLoaderReady);
		}
		
		private function onLoaderReady(evt: LoaderEvent): void
		{
			var _loader: XMLLoader = evt.loader as XMLLoader;
			var _configXML: XML = _loader.configXML;
			
			ResourceLoadManager.load("rocket" + _configXML.resourceId + "_resource", false, "", onResourceLoaded);
		}
		
		private function onResourceLoaded(evt: LoaderEvent): void
		{
			
		}
	}
}