package enum
{
	public class EnumShipDirection
	{
		public static const RADIANS_20: int = 1;
		public static const RADIANS_40: int = 2;
		public static const RADIANS_60: int = 3;
		public static const RADIANS_80: int = 4;
		public static const RADIANS_100: int = 5;
		public static const RADIANS_120: int = 6;
		public static const RADIANS_140: int = 7;
		public static const RADIANS_160: int = 8;
		public static const RADIANS_180: int = 9;
		public static const RADIANS_200: int = 10;
		public static const RADIANS_220: int = 11;
		public static const RADIANS_240: int = 12;
		public static const RADIANS_260: int = 13;
		public static const RADIANS_280: int = 14;
		public static const RADIANS_300: int = 15;
		public static const RADIANS_320: int = 16;
		public static const RADIANS_340: int = 17;
		public static const RADIANS_360: int = 18;
		
		public function EnumShipDirection()
		{
		}
		
		public static function getRadians(x: Number, y: Number): Number
		{
			return Math.atan2(y, x);
		}
		
		public static function getRadians(x: Number, y: Number): Number
		{
			return Math.atan2(y, x);
		}
		
		/**
		 * 角度转弧度
		 * @param	value
		 * @return
		 */
		public static function radiansToDegress(value: Number): Number
		{
			return value * Math.PI / 180;
		}
		
		/**
		 * 弧度转角度
		 * @param	value
		 * @return
		 */
		public static function degressToRadians(value: Number): Number
		{
			return int(value * 180 / Math.PI);
		}
	}
}