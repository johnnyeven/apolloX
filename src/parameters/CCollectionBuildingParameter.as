package parameters
{
	import parameters.basic.CBuildingParameter;
	import utils.network.data.interfaces.IParameterFill;
	
	/**
	 * ...
	 * @author Johnny.EVE
	 */
	public class CCollectionBuildingParameter extends CBuildingParameter
	{
		/**
		 * 消耗的资源
		 */
		private var _consumeList: Vector.<CResourceParameter>;
		/**
		 * 产出的资源
		 */
		private var _produceList: Vector.<CResourceParameter>;
		
		public function CCollectionBuildingParameter() 
		{
			super();
			_consumeList = new Vector.<CResourceParameter>();
			_produceList = new Vector.<CResourceParameter>();
		}
		
		public function get consumeList():Vector.<CResourceParameter> 
		{
			return _consumeList;
		}
		
		public function get produceList():Vector.<CResourceParameter> 
		{
			return _produceList;
		}
		
		override public function fill(data: Object): void
		{
			super.fill(data);
			
			if (data.building_consume != '')
			{
				data.building_consume = JSON.parse(data.building_consume);
				for (var i: String in data.building_consume)
				{
					var consumeResource: CResourceParameter = new CResourceParameter(parseInt(i), data.building_consume[i].resource_name, 0, parseInt(data.building_consume[i].resource_incremental));
					_consumeList.push(consumeResource);
				}
			}
			
			if (data.building_produce != '')
			{
				data.building_produce = JSON.parse(data.building_produce);
				for (var j: String in data.building_produce)
				{
					var produceResource: CResourceParameter = new CResourceParameter(parseInt(j), data.building_produce[j].resource_name, 0, parseInt(data.building_produce[j].resource_incremental));
					_produceList.push(produceResource);
				}
			}
		}
		
	}

}