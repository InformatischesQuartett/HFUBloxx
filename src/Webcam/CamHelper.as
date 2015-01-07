package Webcam
{
	import flash.display.BitmapData;
	import flash.display3D.textures.Texture;
	
	import starling.display.Image;

	public class CamHelper
	{
		public static function uploadFromBitmapData(camImg:Image, camBmpData:BitmapData):void
		{
			flash.display3D.textures.Texture(camImg.texture.base).uploadFromBitmapData(camBmpData);
		}
	}
}