package Screens {

	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	
	import GameObjects.Bloxx;
	import GameObjects.Hat;
	import GameObjects.Pipe;
	import GameObjects.Player;
	
	import Network.NetworkHandler;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.text.TextField;
	
	
	public class MainGame extends BloxxScreen {
		
		/*Game Variables */
		//private var colorBloxxArray : Array;
		private var colorArray : Array;
		private var colorPlayerArray : Array;
		
		public static var currentPipe : Pipe;
		public static var otherPipe: String;
		
		private var gameScore : int = 0;
		
		private var playerOne : Player;
		private var playerTwo : Player;
		
		/*How many Hats are in the game at the same time*/
		private var hatCount : int = 4;
		
		public static var backgroundGame : Image;
		
		private var  textField : TextField;
	
		
		public static var pipeCount : int;
		
		// Mapgrids
		
		//Determins the size of the bloxx
		private var bloxxSize : int = 10;
		
		// Determines how many Bloxx fit in one line
		private static var columnCount : int = 6;
		private static var rowCount : int = 10;
		
		// 2D-Array
		private var gridArray : Array;
		
		
		public var gameSound:Sound = new Sound();
		public var gameChannel:SoundChannel = new SoundChannel();
		
		/**
		 * Constructor of the MainGame
		 */
		public function MainGame(handler:NetworkHandler) {
			//calls super class' constructor
			super(handler);
			
			Starling.current.nativeStage.addEventListener(Event.ENTER_FRAME, update);
			
			trace("Starting MainGame");
			
			//initialize color-choice arrays, the strings are the same as in the Assets.as file
		
			colorArray = new Array("Blue", "Green", "Orange", "Pink", "Red", "Yellow");
			
			colorPlayerArray = new Array("avatar_Yellow", "avatar_Voilet", "avatar_Red", "avatar_Green");
			
			//gridArray for positioning bloxx	
			gridArray = new Array();

			for(var i : int = 0; i < rowCount; i++){
				gridArray[i] = new Array();
				for (var j : int = 0; j < columnCount; j++) {
					gridArray[i][j] = false;
				}
				trace("At row number " + i + " the column values are: " + gridArray[i]);
			}

			//set background Texture of screen
			var bg : Image = new Image(Assets.getTexture("bg"));
			bg.width = HFUBloxx.screenWidth;
			bg.height = HFUBloxx.screenHeight;
			this.addChild(bg);
			
			//set background Texture of game
			backgroundGame = new Image(Assets.getTexture("bg_Game"));
			backgroundGame.width = HFUBloxx.screenWidth/2;
			backgroundGame.height = HFUBloxx.screenHeight;
			this.addChild(backgroundGame);
			
			//chooseBloxxPos();
			FillGrid();
			drawBloxx();
			
			
			//spawns player and adds him to main stage
			this.addChild(spawnPlayers());
			
			for (var k : int = 0; k < hatCount; k++) {
				spawnHat();
			}
			
			drawGUI ();
			
			pipeCount = 0;
			
			gameSound.load(new URLRequest("gameSound.mp3"));
			gameChannel = gameSound.play();		
		
		}//end constructor
		
		/**
		 * Getter for columnCount
		 */
		public static function getColumnCount () : int {
			return columnCount;
		}
		
		/**
		 * Getter for rowCount
		 */
		public static function getRowCount () : int {
			return rowCount;
		}
		
		/**
		 * returns either 1 or 0
		 * for certain random processes
		 **/
		public function randomize (upperBound : int) : int {
			var aNumber : Number =(((Math.random() * 100))  % (upperBound +1)) ;
				return int(aNumber) ;
		}
		
		/**
		 **/
//		public function randomize (anArray : Array) : int {
//			var aNumber : int = 0;
//			return aNumber;
//		}
		
		public function FillGrid() : void{
			for (var i : int = 0; i < rowCount; i++) {
				var blockscreated : int = 0;
				if ((i%2 != 0 || i == 0)) {
					//Debug.Log("i = " + i +" continuing");
					continue;
				}
				var blocksToCreate : int = randomize(2) +2;
				while (blockscreated < blocksToCreate) {
					var xPos : int = randomize(5);
					if (gridArray[i][xPos] == false){
						gridArray[i][xPos] = true;
						blockscreated++;
					}    
				}
			}
			
		}
		
		
		
		/**
		 * Draws the bloxx
		 */
		public function drawBloxx() : void {
			//iterate through 2d Array and build a bloxx when a "true" appears
			for(var i : int = 0; i < rowCount; i++){
				for(var j : int = 0; j < columnCount; j++){
					if(gridArray[i][j] == true){
						trace("BuildWall");
						var aBloxx : Bloxx = new Bloxx(j, i);
						this.addChild(aBloxx);
					}
				}
			}			
		}
		
		/**
		 * Game Loop
		 **/
		public function update(_event : Event) : void{
			checkItemColliderState();
			
			if (currentPipe == null) {
				spawnPipe();
			}
			if (currentPipe.removeMe) {
				spawnPipe();
			}
			
			checkPipeState ();
			checkPlayerState();
			
			textField.text = playerOne.playerLife.toString();
		}
		
		/**
		 * checks if Item (the Hats) is set to remove me and remove it respectively
		 **/
		public function checkItemColliderState() : void{
			// control variable for Array Elements
			var counter : int = 0;
			
			// check colliders for type and handle them differently
			for each (var aCollider:* in HFUBloxx.itemColliderArray){
				if(aCollider.removeMe == true){
					this.removeChild(aCollider);
					spawnHat();
					trace("remove Me");
					
					//remove the counter th Element from the Array (the 1 indicates: only 1 Element)
					HFUBloxx.itemColliderArray.splice(counter, 1);
				}
				counter++;
			}
		}
		
		/**
		 * Spawns a Pipe
		 **/
		public function spawnPipe() : void {
			var tempNo : int = randomize(colorArray.length - 1);
			currentPipe = new Pipe(colorArray[tempNo], pipeCount);
			this.addChild(currentPipe);
			pipeCount++;
			
			netHandler.sendMessage("otherPipeColor", colorArray[tempNo]);
		}
		
		/**
		 * Checks if Pipe hits Ground. If so --> delete it. Spawn next Pipe and reduce PlayerLife.
		 **/
		public function checkPipeState () : void {
			if (currentPipe.y >= (HFUBloxx.screenHeight - HFUBloxx.borderSize ) ) {
				currentPipe.setRemoveMe(true);
				playerOne.setPlayerLife(-1);
			}
			//remove pipe from game
			if (currentPipe.removeMe) {
				this.removeChild(currentPipe);
				spawnPipe();
			}
		}
		
		
		/**
		 * Checks if Game is over.
		 **/
		public function checkPlayerState () : void {
			if (playerOne.playerLife <= 0) {
				gameHandler.loadScreen(GameOver); 
			}
		}
		
		/**
		 * Spawn Players.
		 **/
		public function spawnPlayers() : Player {
			playerOne = new Player("avatar_Yellow", netHandler);
			return playerOne;
		}
		
		public function spawnHat() : void {
				var xPos: int = randomize(columnCount -1);
				var yPos : int = randomize(rowCount -2);
				var tempNo : int = randomize(colorArray.length - 1);
				this.addChild(new Hat(colorArray[tempNo], xPos, yPos));
				
		}
		
		private function drawGUI () : void {
			var heartImg : Image = new Image(Assets.getTexture("herz_Button"));
			heartImg.x = (HFUBloxx.screenWidth * 0.52);
			heartImg.y = HFUBloxx.screenHeight * 0.05;
			heartImg.scaleX = 0.2;
			heartImg.scaleY = 0.2;
			this.addChild(heartImg);
			
			textField  = new TextField(HFUBloxx.screenWidth * 0.1, HFUBloxx.screenHeight * 0.1, playerOne.playerLife.toString()  );
			textField.fontSize = 40;
			textField.color = (0xffffff);
			textField.x = heartImg.x + heartImg.width;
			textField.y = HFUBloxx.screenHeight * 0.04 ;
			
			this.addChild(textField);
			
		}		
		
	}
}