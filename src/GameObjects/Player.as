package GameObjects {
	
	//import HFUBloxx;
	
	import flash.events.Event;
	
	import Screens.MainGame;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	
	
	/**
	 * This class describes a Player
	 **/
	public class Player extends Sprite {
		
		//walking speed --> set in an external xml file
		private var walkSpeed : int = 4; // = int(HFUBloxx.xmlContent.Player.playerSpeed.@ps);
		private var jumpSpeed : int = 10;
		private var isJumping : Boolean = false;
		
		//image
		private var playerImage : Image;
		
		//Gravity
		private var forceFall : Number = 0;
		private var fallSpeed : Number = 0.5;
		
		private var gameBorderRight:Number;
		private var gameBorderLeft:Number;
		
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
			
			gameBorderRight = (MainGame.backgroundGame.width/2 ) - (this.width/2) -10;
			gameBorderLeft = -(MainGame.backgroundGame.width/2) + (this.width/2) + 10; 
			
			trace("player spawned " + playerImage.x + playerImage);
		}//constructor end
		
		/**
		 * Method is called each frame from event listener above.
		 **/ 
		public function update (_event : Event) : void {
			//check for collision
			checkCollision();
			doPhysic();

			//movement			
			if (HFUBloxx.left)
				playerMove("left");
			
			if (HFUBloxx.right)
				playerMove("right");
			
			if (HFUBloxx.up)
				playerMove("up");
			
		}//end update method
		
		/**
		 * Checks if avatar hits objects
		 **/ 
		public function checkCollision() : void {
			//MainGame.testHat.setRemoveMe();
			for each (var oCollider : Object in HFUBloxx.colliderArray) {
				if (this.getBounds(this.parent).intersects(oCollider.getBounds(MainGame.testHat.parent)))
				{
					//trace("collision");
					oCollider.setRemoveMe(true);
				}
			}
		}
		
		/**
		 * Handles the Player's Movement
		 **/
		public function playerMove(directions : String) : void {
			var tempX: int;
			
			switch (directions) {
				case "left":
					tempX = this.x - walkSpeed;
					break;
				
				case "right":
					tempX = this.x + walkSpeed;
					break;
				
				case "up":
					if (!isJumping) {
						forceFall = -jumpSpeed;
						isJumping = true;
					}
					break;
				
				case "down":
					break;
				
				default:
					break;
			} //end switch
			
			//check for stage edges
			if (tempX > gameBorderRight)
				tempX = gameBorderRight - 1;
			
			if (tempX < gameBorderLeft)
				tempX = gameBorderLeft + 1;
			
			if (directions == "left" || directions == "right")
				this.x = tempX;
		}
		
		public function doPhysic() : void{			
			forceFall += fallSpeed;

			this.y += forceFall;
			this.y = Math.min(0, this.y);
			
			if (this.y == 0) {
				isJumping = false;
				forceFall = 0;
			}
		}
		
	} //class end
}