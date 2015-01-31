package Screens
{
	import Network.NetworkHandler;
	
	import starling.display.Sprite;
	
	public class BloxxScreen extends Sprite
	{
		protected var gameHandler:HFUBloxx;
		protected var netHandler:NetworkHandler;
		
		public function BloxxScreen(net:NetworkHandler)
		{
			super();
			
			netHandler = net;
		}
		
		public function setHandler(game:HFUBloxx, net:NetworkHandler):void
		{
			gameHandler = game;
			netHandler = net;
		}
	}
}