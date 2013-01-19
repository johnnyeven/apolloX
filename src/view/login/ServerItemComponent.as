package view.login
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.errors.IllegalOperationError;
	import flash.events.MouseEvent;
	
	import parameters.CServerListParameter;
	
	import utils.liteui.component.Label;
	import utils.liteui.core.Component;
	import utils.resource.ResourcePool;
	
	public class ServerItemComponent extends Component
	{
		private var silverRiver1: MovieClip;
		private var silverRiver2: MovieClip;
		private var lblServerName: Label;
		
		public function ServerItemComponent(parameter: CServerListParameter)
		{
			if(parameter != null)
			{
				super(ResourcePool.getResource("ui.login.ServerItemSkin") as DisplayObjectContainer);
				
				silverRiver1 = getSkin("silverRiver1") as MovieClip;
				silverRiver2 = getSkin("silverRiver2") as MovieClip;
				lblServerName = getUI(Label, "lblServerName") as Label;
				
				silverRiver1.visible = false;
				silverRiver2.visible = false;
				
				if(parameter.hot)
				{
					silverRiver2.visible = true;
				}
				else
				{
					silverRiver1.visible = true;
				}
				lblServerName.text = parameter.name;
				
				sortChildIndex();
				
				addEventListener(MouseEvent.CLICK, onServerClick);
			}
			else
			{
				throw new IllegalOperationError("[Error]<ServerItemComponent>: CServerListParameter必须定义");
			}
		}
		
		private function onServerClick(evt: MouseEvent): void
		{
			trace("click");
		}
	}
}