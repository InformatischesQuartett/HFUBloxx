package Network 
{
	import flash.events.Event;
	import flash.events.NetDataEvent;
	import flash.events.NetStatusEvent;
	import flash.events.StatusEvent;
	import flash.events.TimerEvent;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.Timer;
	
	import Webcam.CamHandler;
	
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.Color;
	import starling.utils.HAlign;
	
	public class NetworkHandler extends Sprite
	{
		public var netConnection:NetConnection;
		public var netSendStream:NetStream;
		public var netRecvStream:NetStream;

		private var netConnectTimer:Timer;
		private var netConnectLimit:Number = 5000;
		private var netConnectTimeout:Boolean;
		
		private var netStatus: TextField;
		
		private var camHandler: CamHandler;
  
		public var localID: int;
		
		public function NetworkHandler()
		{
			localID = int (Math.random() * 100000);
			
			// network information
			netStatus = new TextField(500, 20, "--", "Arial", 12, Color.WHITE);
			netStatus.hAlign = HAlign.LEFT;
			
			netStatus.x = 5;
			netStatus.y = 5;
			
			this.addChild(netStatus);
			
			// create connection to the FMS
			netConnection = new NetConnection();
			
			netConnection.client = this;
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
		
		// NetConnection Client //
		
		public function onBWDone(...rest):void
		{ 
			var p_bw:Number;
			
			if (rest.length > 0)
				p_bw = rest[0];

			if (!isNaN(p_bw))
				trace("bandwidth = " + p_bw + " Kbps."); 
		} 
				
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
					
					netSendStream.addEventListener(NetStatusEvent.NET_STATUS, netSendStreamStatus);
					netSendStream.publish("hfubloxx_" + localID);
					netSendStream.videoSampleAccess = true;
					
					camHandler.sendToStream(netSendStream);
					
					// open receiving stream
					netRecvStream = new NetStream(netConnection);
					netRecvStream.client = this;
					
					netRecvStream.addEventListener(NetStatusEvent.NET_STATUS, netRecvStreamStatus);
				    netRecvStream.play("hfubloxx_" + localID);
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
		
		// NetSendStream Client //
		
		private function netSendStreamStatus(event:NetStatusEvent):void
		{
			updateStatus(event.info.code + " (NetSendStream)");
		}

		// NetRecvStream Client //
		
		private function netRecvStreamStatus(event:NetStatusEvent):void
		{
			updateStatus(event.info.code + " (NetRecvStream)");
		}

		public function receiveSomeData(str:Object):void
		{
			trace("Incoming: " + str);
		}
		
		public function sendMessage(type:String, message:String):void
		{
			netSendStream.send("receiveSomeData", "Hallo :-)");
			camHandler.recvFromStream(netRecvStream);
		}
						
		public function updateStatus(message:String):void
		{   
			trace("Network: " + message);
			netStatus.text = "Network: " + message;
		}
		
		public function setCamHandler(handler:CamHandler):void
		{
			camHandler = handler;
		}
	}
}