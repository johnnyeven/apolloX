package utils 
{
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.DataEvent;
	/**
	 * ...
	 * @author john
	 */
	public class Conversion 
	{
		public function Conversion() 
		{
			
		}
		
		public static function Bitmap(data: *): BitmapData
		{
			if (data == null)
			{
				return null
			}
			else if (data is Class)
			{
				try
				{
					data = new data();
					if (data is MovieClip)
					{
						var bitmap: BitmapData = new BitmapData(data.width, data.height);
						bitmap.draw(data);
						data = bitmap;
					}
				}
				catch (err: ArgumentError)
				{
					data = new data(0, 0);
				}
			}
			
			return data;
		}
	}

}