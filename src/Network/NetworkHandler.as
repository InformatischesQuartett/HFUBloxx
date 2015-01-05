package Network 
{
	import com.shephertz.appwarp.WarpClient;
	import com.shephertz.appwarp.types.ConnectionState;
	
	import flash.utils.ByteArray;
	
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.Color;
	import starling.utils.HAlign;
	
	public class NetworkHandler extends Sprite
	{
		private var netListener: AppWarpListener;
		
		private var netStatus: TextField;
		
		// AppWarp String Constants        
		public var localUsername: String;
		
		public var roomID: String = "1843039564";
		private var apiKey: String = "be4984d117a2f504f8b6917b127110b7eded570498b65c942eea9219f79b1fa8";
			
		[Embed(source="config.ini", mimeType="application/octet-stream")]
		public static const privateKeyFile: Class;	
		
		public function NetworkHandler()
		{
			netListener = new AppWarpListener(this);
			
			// read private key and connect
			var bytes:ByteArray = new privateKeyFile();
			var secretKey:String = bytes.readUTFBytes(bytes.length);

			if (secretKey.length == 0)
				throw Error("Config.ini is empty. Add private key.");
			
			WarpClient.initialize(apiKey, secretKey);
			
			WarpClient.getInstance().setConnectionRequestListener(netListener);
			WarpClient.getInstance().setRoomRequestListener(netListener);
			WarpClient.getInstance().setNotificationListener(netListener);
			
			localUsername = Math.random().toString();
			
			WarpClient.getInstance().connect(localUsername);
			
			// network information
			netStatus = new TextField(500, 20, "Network: Connecting...", "Arial", 12, Color.WHITE);
			netStatus.hAlign = HAlign.LEFT;
			
			netStatus.x = 5;
			netStatus.y = 5;
			
			this.addChild(netStatus);
		}
		
		public function updateStatus(message:String):void
		{   
			netStatus.text = "Network: " + message;
		}
	}
}