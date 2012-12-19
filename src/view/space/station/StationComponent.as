package view.space.station
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	
	import parameters.space.SpaceStationParameter;
	
	import utils.liteui.component.Button;
	import utils.resource.ResourcePool;
	
	import view.space.StaticComponent;

	public class StationComponent extends StaticComponent
	{
		protected var _info: SpaceStationParameter;
		private var _btnTask: Button;
		private var _selectedSkin: MovieClip;
		
		public function StationComponent(parameter: SpaceStationParameter=null)
		{
			super();
			if(parameter != null)
			{
				_info = parameter;
				_posX = parameter.x;
				_posY = parameter.y;
			}
			
			loadResource();
		}

		public function get info():SpaceStationParameter
		{
			return _info;
		}

		public function set info(value:SpaceStationParameter):void
		{
			_info = value;
		}
		
		override protected function loadResource(): void
		{
			ResourcePool.getResourceByLoader("resources/station/station" + _info.stationResource + ".swf", "space.station.Station" + _info.stationResource, onResourceLoaded);
		}
		
		protected function onResourceLoaded(target: DisplayObject): void
		{
			_graphic = target as MovieClip;
			
			_btnTask = getUIByDisplay(Button, _graphic.getChildByName("btnTask")) as Button;
			_selectedSkin = _graphic.getChildByName("selected") as MovieClip;
			
			addChild(_graphic);
			
			sortChildIndex();
		}
	}
}