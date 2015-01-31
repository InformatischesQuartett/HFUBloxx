package Network 
{
	import flash.events.NetStatusEvent;
	import flash.events.TimerEvent;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.Timer;
	
	import Screens.GameOver;
	import Screens.MainGame;
	
	import Webcam.CamHandler;
	
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.Color;
	import starling.utils.HAlign;
	
	public class NetworkHandler extends Sprite
	{
		private var netConnection:NetConnection;
		private var netSendStream:NetStream;
		private var netRecvStream:NetStream;

		private var netConnectTimer:Timer;
		private var netConnectLimit:Number = 5000;
		private var netConnectTimeout:Boolean;
		
		private var netStatus: TextField;
		
		private var gameHandler: HFUBloxx;
		private var camHandler: CamHandler;
  
		public static var localID: String = "Schwenningen";
		public static var remoteID: String;
		
		public function NetworkHandler()
		{
			// location
			if (localID == "Furtwangen")
				remoteID = "Schwenningen";
			else
				remoteID = "Furtwangen";
			
			// network information
			netStatus = new TextField(500, 20, "--", "Arial", 12, Color.WHITE);
			netStatus.hAlign = HAlign.LEFT;
			
			netStatus.x = 5;
			netStatus.y = 5;
			
			this.addChild(netStatus);
			
			// create connection to the FMS
			netConnection = new NetConnection();
			
			netConnection.client = { onBWDone: function():void { } };
			netConnection.addEventListener(NetStatusEvent.NET_STATUS, netConnectionStatus);

			netConnectTimeout = false;
			netConnectTimer = new Timer(netConnectLimit);
			netConnectTimer.addEventListener(TimerEvent.TIMER, connectionTimeout);
			
			connectToRTMP();
		}
		
		private function connectToRTMP():void {
			updateStatus("Connecting to the RTMP server...");
			
			netConnection.connect("rtmfp://141.28.126.83/live");
			netConnectTimer.start();
		}
		
		private function connectionTimeout(e:TimerEvent):void {
			netConnectTimeout = !netConnectTimeout;
			
			if (!netConnectTimeout)
				connectToRTMP();
			else
				netConnection.close();
		}
		
		public function setGameHandler(handler:HFUBloxx):void
		{
			gameHandler = handler;
		}
		
		public function setCamHandler(handler:CamHandler):void
		{
			camHandler = handler;
		}
		
		public function setNetStatusVisibility(visible:Boolean):void
		{
			netStatus.visible = visible;
		}
		
		public function sendMessage(type:String, message:*):void
		{
			if (netSendStream != null) {
				var msg:Object = new Object();
				
				msg.senderID = localID;
				
				switch(type)
				{					
					default:
						msg.data = message;
				}
				
				netSendStream.send(type, msg);
				updateStatus("Sent message '" + message + "' of type '" + type + "'.");
			}
		}
		
		private function isLocalMsg(msg:Object):Boolean
		{
			return (msg.senderID == localID);
		}
		
		public function updateStatus(message:String):void
		{   
			trace("Network: " + message);
			netStatus.text = "Network: " + message;
		}
		
		// netConnection events //
		
		private function netConnectionStatus(event:NetStatusEvent):void
		{
			updateStatus(event.info.code + " (NetConnection)");
			
			switch(event.info.code)
			{
				case "NetConnection.Connect.Success":
				{
					netConnectTimer.stop();
					
					// open sending stream
					netSendStream = new NetStream(netConnection);
					netSendStream.client = this;
					
					netSendStream.addEventListener(NetStatusEvent.NET_STATUS, netStreamSendStatus);
					netSendStream.publish("hfubloxx_" + localID);
					netSendStream.videoSampleAccess = true;
					
					camHandler.sendToStream(netSendStream);
					
					// open receiving stream
					netRecvStream = new NetStream(netConnection);
					netRecvStream.client = this;
					
					netRecvStream.addEventListener(NetStatusEvent.NET_STATUS, netStreamRecvStatus);
				    netRecvStream.play("hfubloxx_" + remoteID);
					netRecvStream.bufferTime = 0.5;
					
					camHandler.recvFromStream(netRecvStream);
					
					break;
				}
					
				case "NetConnection.Connect.Closed":
				{
					if (netConnectTimeout) {
						var secs:int = int (netConnectLimit/1000);
						updateStatus("Timeout. Reconnecting in " + secs + " seconds...");
					} else
						updateStatus("Connection to the RTMP server has been closed.");
					
					break;
				}
			}
		}
		
		// netSendStream / netRecvStream events //
				
		private function netStreamSendStatus(event:NetStatusEvent):void
		{
			var appendix:String = " (netSendStream)";
			
			switch (event.info.code)
			{
				case "NetStream.Publish.Start":
				{
					camHandler.sendToStream(netSendStream);
					updateStatus(event.info.code + appendix);
					
					return;
				}
			}
			
			updateStatus(event.info.code + appendix);
		}
				
		private function netStreamRecvStatus(event:NetStatusEvent):void
		{
			var appendix:String = " (netRecvStream)";
			
			switch (event.info.code)
			{
				case "NetStream.Buffer.Empty":
					return;
					
				case "NetStream.Buffer.Full":
					return;
					
				case "NetStream.Video.DimensionChange":
				{
					updateStatus("Receiving video/audio stream data" + appendix);
					return;
				}
			}
			
			updateStatus(event.info.code + appendix);
		}
		
		public function startGameViaNet(msg:Object): void
		{
			if (!isLocalMsg(msg))
				gameHandler.loadScreen(MainGame, true)
		}
		
		public function gameOverViaNet(msg:Object): void
		{
			if (!isLocalMsg(msg))
				gameHandler.loadScreen(GameOver, true);
		}
		
		public function otherPipeColor(msg:Object): void
		{
			if (!isLocalMsg(msg))
				MainGame.otherPipe = msg.data;
		}
		
		public function removePipe(msg:Object): void
		{
			if (!isLocalMsg(msg))
				MainGame.currentPipe.setRemoveMe(true);
		}
	}
}