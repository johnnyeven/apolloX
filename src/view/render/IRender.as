package view.render
{
	import utils.liteui.core.Component;
	
	public interface IRender
	{
		function rendering(force: Boolean = false): void;
		function get target():Component;
		function set target(value: Component):void;
	}
}