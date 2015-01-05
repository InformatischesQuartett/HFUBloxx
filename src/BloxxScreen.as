package
{
	import Network.NetworkHandler;
	
	import starling.display.Sprite;
	
	public class BloxxScreen extends Sprite
	{
		protected var gameHandler:HFUBloxx;
		protected var netHandler:NetworkHandler;
		
		public function BloxxScreen()
		{
			super();
		}
		
		public function setHandler(game:HFUBloxx, net:NetworkHandler):void
		{
			gameHandler = game;
			netHandler = net;
		}
	}
}