package GameObjects {
	
	import HFUBloxx;
	
	//try to minimize these imports later on
	import flash.events.Event;
	//import flash.events.KeyboardEvent;
	//import flash.events.MouseEvent;
		
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	/**
	 * This class describes a Player
	 **/
	public class Player extends Sprite {
		
		//walking speed --> set in an external xml file
		private var playerSpeed : int = 100; // = int(HFUBloxx.xmlContent.Player.playerSpeed.@ps);
		//image
		private var playerImage : Image;
		
		/**
		 * Constructor
		 **/
		public function Player(color : String) {
			super();
			
			//set up event listener which is called per frame
			Starling.current.nativeStage.addEventListener(Event.ENTER_FRAME, update);
			
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
		}//constructor end
		
		/**
		 * Method is called each frame from event listener above.
		 **/ 
		public function update (_event : Event) : void {
			trace("This is the Player's Update method");
			//check for collision
			checkCollision();
			
			//movement
			//if (HFUBloxx.left) {
			//	playerMove("left");
			//}
			
		}//end update method
		
		/**
		 * Checks if avatar hits objects
		 **/ 
		public function checkCollision() : void {
			
		}
		
		/**
		 * Handles the Player's Movement
		 **/
		public function playerMove(directions : String) : void {
			var tempX : int;
			switch (directions) {
				case "left":
					tempX = this.x - playerSpeed;
					break;
				case "right":
					tempX = this.x + playerSpeed;
					break;
				case "up":
					break;
				case "down":
					break;
				default:
					break;
			} //end switch
			
			//check for stage edges
		}
	}//class end
}