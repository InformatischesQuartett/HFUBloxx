package GameObjects {
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	/**
	 * This class describes a Player
	 **/
	public class Player extends Sprite {
		
		//defines the image size of the ghost avatar
		private const playerSize : int = 40;
		//describes the size of the black border stroke from the gamescreen
		private const borderSize : int = 20;
		
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
			playerImage.width = playerSize;
			playerImage.height = playerSize;
			
			//position
			playerImage.x = (HFUBloxx.GameWidth/4) - (playerImage.width/2);
			playerImage.y = (HFUBloxx.GameHeight - playerImage.height)- borderSize;
			
			//adds Image to this stage
			this.addChild(playerImage);
			
			trace("player spawned " + playerImage.x + playerImage);
		}
	}
}