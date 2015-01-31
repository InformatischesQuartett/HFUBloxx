package GameObjects {
	
	//import HFUBloxx;
	
	//import flash.display.DisplayObject;
	
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	
	import Screens.MainGame;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.TextureSmoothing;
	
	
	/**
	 * This class describes a Player
	 **/
	public class Player extends Sprite {
		
		//walking speed --> set in an external xml file
		private var walkSpeed : int = 6; // = int(HFUBloxx.xmlContent.Player.playerSpeed.@ps);
		private var jumpSpeed : int = 15;
		private var isJumping : Boolean = false;
		
		public var playerLife : int = 1;
		
		//define new Rectangle that defines the feetcollider of the player
		private var playerFeetCollider : Sprite;
		private var playerHeadCollider : Sprite;
		
		//image
		private var playerImage : Image;
		private var feetColliderImage : Image;
		private var headColliderImage : Image;
		
		//Gravity
		private var forceFall : Number = 0;
		private var fallSpeed : Number = 0.5;
		
		private var gameBorderRight:Number;
		private var gameBorderLeft:Number;
		
		public var jumpSound:Sound = new Sound();
		public var jumpChannel:SoundChannel = new SoundChannel();
		
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
			playerImage.smoothing = TextureSmoothing.TRILINEAR;
			
			feetColliderImage = new Image(Assets.getTexture("hat_Pink"));
			headColliderImage = new Image(Assets.getTexture("hat_Blue"));
			
			//position
			playerImage.x = (HFUBloxx.screenWidth/4) - (playerImage.width/2);
			playerImage.y = (HFUBloxx.screenHeight - playerImage.height)- HFUBloxx.borderSize;
			
			//adds Image to this stage
			this.addChild(playerImage);
			
			
			/*Colliders*/
			playerFeetCollider = new Sprite();
			playerHeadCollider = new Sprite();
			
			playerFeetCollider.addChild(feetColliderImage);
			
			playerFeetCollider.width = playerImage.width;
			playerFeetCollider.height = playerImage.height * 0.2;
			playerFeetCollider.x = playerImage.x;
			playerFeetCollider.y = playerImage.y * 1.06;//1.05;
			feetColliderImage.alpha = 0;
			//add Collider to this stage
			this.addChild(playerFeetCollider);
			
			playerHeadCollider.addChild(headColliderImage);
			
			playerHeadCollider.width = playerImage.width;
			playerHeadCollider.height = playerImage.height* 0.7;
			playerHeadCollider.x = playerImage.x;
			playerHeadCollider.y = playerImage.y;
			headColliderImage.alpha = 0;
			//add Collider to this stage
			this.addChild(playerHeadCollider);
			
			
			
			
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
			
			//if(isJumping == true){
				//jumpChannel = jumpSound.play();
			//}
			
			//trace(playerFeetCollider.getBounds(playerFeetCollider.parent.parent));
			
		}//end update method
		
		/**
		 * Checks if avatar hits objects
		 **/ 
		public function checkCollision() : void {
			//MainGame.testHat.setRemoveMe();
			for each (var oCollider : Object in HFUBloxx.itemColliderArray) {
				if (this.getBounds(this.parent).intersects(oCollider.getBounds(oCollider.parent)))
				{
					//trace("collision");
					if ((oCollider as Hat).colorAttribute == MainGame.otherPipe) {
						MainGame.currentPipe.setRemoveMe(true);
						trace("same color");
					}
					oCollider.setRemoveMe(true);
				}
			}
		}
		
		
		/**
		 * Handles the Player's Movement
		 **/
		public function playerMove(directions : String) : void {
			var tempX: int;
			//jumpSound.load(new URLRequest("jumping.mp3"));
						
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
			
			
			/*Run through wall array and check for collision*/
			for each (var aCollider : Object in HFUBloxx.wallColliderArray) {
				
				var feetHit : Boolean = playerFeetCollider.getBounds(this.parent).intersects(aCollider.getBounds(this.parent));
				var headHit : Boolean = playerHeadCollider.getBounds(this.parent).intersects(aCollider.getBounds(this.parent));
				
				if (headHit && feetHit ) {
					/*Ran against wall with whole body including feet*/
					
				} else if (feetHit && !headHit) {
					/*Jump on wall*/
					
					while (feetHit) {
						this.y -= 0.5;
						feetHit = playerFeetCollider.getBounds(this.parent).intersects(aCollider.getBounds(this.parent));
						
					}
					forceFall = 0; //setting back force fall
					isJumping = false; //again on a Bloxx or the floor
				}
			} //end for each
		}
		
		public function setPlayerLife(number : int) : void{
			playerLife += number;
		}
		
	} //class end
}