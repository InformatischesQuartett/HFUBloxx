package GameObjects {
	
	//import HFUBloxx;
	
	import Screens.MainGame;
	
	import flash.events.Event;
	
	import flashx.textLayout.formats.BackgroundColor;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	
	/**
	 * This class describes a Player
	 **/
	public class Player extends Sprite {
		
		//walking speed --> set in an external xml file
		private var playerSpeed : int = 4; // = int(HFUBloxx.xmlContent.Player.playerSpeed.@ps);
		//image
		private var playerImage : Image;
		
		//Gravity
		private var forceFall : int = 0;
		private var fallSpeed : int  = 0.5;
		
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
			//check for collision
			checkCollision();
			doPhysic();
			
			var test : Boolean = true;
			
			
			//movement			
			if (HFUBloxx.left) {
				playerMove("left");
			}else if(HFUBloxx.right){
				playerMove("right");
			}else if(HFUBloxx.up){
				playerMove("up");
			}
			
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
			var tempY : int;
			switch (directions) {
				case "left":
					tempX = this.x - playerSpeed;
					//trace("");
					break;
				case "right":
					tempX = this.x + playerSpeed;
					break;
				case "up":
					tempY = this.y - playerSpeed;
					break;
				case "down":
					break;
				default:
					break;
			} //end switch
			
			//check for stage edges
			if ((tempX > 0 - (MainGame.backgroundGame.width / 2 - HFUBloxx.borderSize)) && (tempX < MainGame.backgroundGame.width))
			{
				
				
				if(directions == "left" || directions == "right"){
					trace("Right and left");
					this.x = tempX;
				}else if(directions == "up"){
					this.y = tempY;
				}
			
			}
		}
		
		public function doPhysic() : void{
			forceFall  += 1;
			//this.y += forceFall;			
		}
		
	}//class end
}