package parameters.space
{
	import utils.network.data.interfaces.IParameterFill;
	
	import view.space.StaticComponent;

	public class RocketLuanchParameter implements IParameterFill
	{
		public var target: StaticComponent;
		public var config: XML;
		
		public function RocketLuanchParameter()
		{
		}
		
		public function fill(data:Object):void
		{
			if(data != null)
			{
				target = data.target;
				config = data.config;
			}
		}
	}
}