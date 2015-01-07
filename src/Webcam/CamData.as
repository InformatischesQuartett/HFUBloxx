package Webcam
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.media.Video;
	import flash.net.NetStream;
	
	import starling.display.Image;

	public class CamData
	{
		public var camSize:Rectangle;
		
		public var camVid:Video;
		public var camImg:Image;
		public var camBmpData:BitmapData;

		public var netStream:NetStream;
		
		public function cleanData():void
		{
			camVid = null;
			camImg = null;
			camBmpData = null;
			camSize = null;
		}
	}
}