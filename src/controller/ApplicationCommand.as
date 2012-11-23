package controller
{
	import com.greensock.plugins.TransformAroundCenterPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import controller.init.*;
	import controller.login.CreateStartMediatorCommand;
	import controller.scene.LoadSceneResourcesCommand;
	
	import mediator.PromptMediator;
	import mediator.StageMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import proxy.LoginProxy;
	import proxy.ServerListProxy;
	
	import view.PromptComponent;
	
	public class ApplicationCommand extends SimpleCommand
	{
		public function ApplicationCommand()
		{
			super();
		}
		
		override public function execute(notification: INotification): void
		{
			TweenPlugin.activate([TransformAroundCenterPlugin]);
			
			facade.registerCommand(LoadResourcesCommand.LOAD_RESOURCES_NOTE, LoadResourcesCommand);
			facade.registerCommand(CreateStartMediatorCommand.CREATE_LOGIN_VIEW_NOTE, CreateStartMediatorCommand);
			facade.registerCommand(LoadServerListCommand.LOAD_SERVERLIST_NOTE, LoadServerListCommand);
			facade.registerCommand(LoadResourceConfigCommand.LOAD_CONFIG_NOTE, LoadResourceConfigCommand);
			facade.registerCommand(LoadSceneResourcesCommand.LOAD_RESOURCES_NOTE, LoadSceneResourcesCommand);
			
			var _main: Main = notification.getBody() as Main;
			
			facade.registerMediator(new StageMediator(_main));
			facade.registerMediator(new PromptMediator());
			
			facade.registerProxy(new ServerListProxy());
			facade.registerProxy(new LoginProxy());
			
			CONFIG::DebugMode
			{
				trace("Main Loaded");
			}
			//sendNotification(LoadResourcesCommand.LOAD_RESOURCES_NOTE);
			sendNotification(LoadResourceConfigCommand.LOAD_CONFIG_NOTE);
		}
	}
}