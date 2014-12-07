package GameObjects {
	
	import HFUBloxx;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	/**
	 * This class describes a Player
	 **/
	public class Player extends Sprite {
		
		//walking speed
		private var speed : int = 100;
		//image
		private var playerImage : Image;
		
		/**
		 * Constructor
		 **/
		public function Player(color : String) {
			super();
			//set image of the ghost according to player's choice
			playerImage =  new Image(Assets.getTexture(color));
			playerImage.width = HFUBloxx.playerSize;
			playerImage.height = HFUBloxx.playerSize;
			
			//position
			playerImage.x = (HFUBloxx.GameWidth/4) - (playerImage.width/2);
			playerImage.y = (HFUBloxx.GameHeight - playerImage.height)- HFUBloxx.borderSize;
			
			//adds Image to this stage
			this.addChild(playerImage);
			
			trace("player spawned " + playerImage.x + playerImage);
		}
	}
}