package view.render
{
	import view.space.StaticComponent;
	
	public interface IRender
	{
		function rendering(force: Boolean = false): void;
		function get target():StaticComponent;
		function set target(value: StaticComponent):void;
	}
}