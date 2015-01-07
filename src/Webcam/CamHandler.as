package Webcam
{
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.media.Camera;
	import flash.media.Microphone;
	import flash.media.Video;
	import flash.net.NetStream;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	public class CamHandler extends Sprite
	{
		private var camera:Camera;
		private var microphone:Microphone;
		
		private var localCam:CamData;
		private var remoteCam:CamData;

		public function CamHandler()
		{
			localCam = new CamData();
			remoteCam = new CamData();
		}
		
		private function setImage(camType:CamData, pos:Rectangle, visible:Boolean):void
		{
			if (camType.camImg != null)
				removeChild(camType.camImg);
			
			camType.cleanData();
			camType.camSize = new Rectangle(0, 0, pos.width, pos.height);
			camType.camBmpData = new BitmapData(pos.width, pos.height);
			
			// use dummy image until webcam is available
			var dummyBmp:BitmapData = new Assets.misc_Person().bitmapData;
			
			var matrix:Matrix = new Matrix();
			matrix.scale(pos.width/dummyBmp.width, pos.height/dummyBmp.height);
			camType.camBmpData.draw(dummyBmp, matrix);
			
			// create dynamic image/texture
			var tex:Texture = Texture.fromBitmapData(camType.camBmpData);
			
			camType.camImg = new Image(tex);
			camType.camImg.x = pos.left;
			camType.camImg.y = pos.top;
			camType.camImg.visible = visible;
			
			addChild(camType.camImg);
		}
		
		public function setLocalImage(pos:Rectangle, visible:Boolean=true):void
		{
			setImage(localCam, pos, visible);
		}
		
		public function setRemoteImage(pos:Rectangle, visible:Boolean=true):void
		{
			setImage(remoteCam, pos, visible);
			
			if (remoteCam.netStream != null)
				recvFromStream(remoteCam.netStream);
		}
		
		public function setLocalVisibility(visible:Boolean):void
		{
			if (localCam.camImg != null)
				localCam.camImg.visible = visible;
		}
		
		public function setRemoteVisibility(visible:Boolean):void
		{
			if (remoteCam.camImg != null)
				remoteCam.camImg.visible = visible;
		}

		public function attachCamera():void
		{
			if (localCam.camVid)
			{
				localCam.camVid.attachCamera(null);
				
				camera.removeEventListener(Event.ENTER_FRAME, onVideoFrame);
				camera = null;
				
				microphone = null;
			}
			
			if (Camera)
			{
				camera = Camera.getCamera();
				
				if (camera)
				{
					camera.setMode(localCam.camSize.width, localCam.camSize.height, 24);
					
					localCam.camVid = new Video(localCam.camSize.height, localCam.camSize.width);
					localCam.camVid.attachCamera(camera);
					
					camera.addEventListener(Event.VIDEO_FRAME, onVideoFrame);
				} else
					throw Error("No camera found.");
			}
			
			/*
				microphone = Microphone.getMicrophone();
				
				if (microphone)
				{
					// settings
				} else
					throw Error("No microphone found.");
			*/

			if (localCam.netStream != null)
				sendToStream(localCam.netStream);
		}
		
		private function onVideoFrame(evt:Event):void {
			localCam.camBmpData.draw(localCam.camVid);
			CamHelper.uploadFromBitmapData(localCam.camImg, localCam.camBmpData);
		}
		
		public function sendToStream(netStream:NetStream):void
		{
			localCam.netStream = netStream;
			
			if (camera != null)
				netStream.attachCamera(camera);
			
			if (microphone != null)
				netStream.attachAudio(microphone);
		}
		
		public function recvFromStream(netStream:NetStream):void
		{
			remoteCam.netStream = netStream;
			
			if (remoteCam.camVid != null) {
				remoteCam.camVid = new Video(remoteCam.camSize.height, remoteCam.camSize.width);
				remoteCam.camVid.attachNetStream(netStream);
				
				remoteCam.camVid.addEventListener(Event.ENTER_FRAME, onVideoFrame);
			}
		}
	}
}