package utils.network.data.basic 
{
	import utils.network.data.interfaces.IParameterFill;
	//import objects.dependency.CDependency;
	
	/**
	 * ...
	 * @author Johnny.EVE
	 */
	public class CBuildingParameter implements IParameterFill
	{
		private var _objectId: String;
		private var _resourceId: String;
		private var _buildingId: uint;
		private var _buildingName: String;
		private var _buildingLevel: uint;
		private var _x: int;
		private var _y: int;
		//private var _dependency: CDependency;
		
		public function CBuildingParameter() 
		{
		}
		
		public function get x():int 
		{
			return _x;
		}
		
		public function get y():int 
		{
			return _y;
		}
		
		public function get buildingLevel():uint 
		{
			return _buildingLevel;
		}
		
		public function get buildingName():String 
		{
			return _buildingName;
		}
		
		public function get buildingId():uint 
		{
			return _buildingId;
		}
		
		public function get resourceId():String 
		{
			return _resourceId;
		}
		
		public function get objectId():String 
		{
			return _objectId;
		}
		
//		public function get dependency():CDependency 
//		{
//			return _dependency;
//		}
//		
//		public function set dependency(value:CDependency):void 
//		{
//			_dependency = value;
//		}
		
		public function fill(data: Object): void
		{
			_objectId = data.object_id;
			_resourceId = data.resource_id;
			_buildingId = data.building_id;
			_buildingName = data.building_name;
			_buildingLevel = data.building_level;
			_x = data.building_pos_x;
			_y = data.building_pos_y;
			
			if (data.building_dependency != '')
			{
				data.building_dependency = JSON.parse(data.building_dependency);
			}
		}
		
	}

}