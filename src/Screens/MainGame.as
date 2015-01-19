package Screens {

	import flash.events.Event;
	
	import GameObjects.Bloxx;
	import GameObjects.Hat;
	import GameObjects.Player;
	
	import starling.core.Starling;
	import starling.display.Image;
	
	public class MainGame extends BloxxScreen {
		
		/*Game Variables */
		private var colorBloxxArray : Array;
		private var colorHatPipeArray : Array;
		private var colorPlayerArray : Array;
		
		private var gameScore : int = 0;
		
		private var playerOne : Player;
		private var playerTwo : Player;
		
		public static var backgroundGame : Image;
		
		public static var testHat : Hat;
		
		// Mapgrids
		
		//Determins the size of the bloxx
		private var bloxxSize : int = 10;
		
		// Determines how many Bloxx fit in one line
		private static var columnCount : int = 6;
		private static var rowCount : int = 10;
		
		// 2D-Array
		private var gridArray : Array;
		
		/**
		 * Constructor of the MainGame
		 */
		public function MainGame() {
			//calls super class' constructor
			super();
			
			Starling.current.nativeStage.addEventListener(Event.ENTER_FRAME, update);
			
			trace("Starting MainGame");
			
			//initialize color-choice arrays, the strings are the same as in the Assets.as file
			colorBloxxArray = new Array("blue", "gray", "lightGreen", "darkGreen", "lilac", "orange", "red", "turquoise", "yellow");
		
			colorHatPipeArray = new Array("green", "pink", "yellow", "blue");
			
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
			
			chooseBloxxPos();
			drawBloxx();
			
			//spawns player and adds him to main stage
			testHat = new Hat();
			this.addChild(testHat);
			this.addChild(spawnPlayers());
			
		
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
		public function randomize () : int {
			var aNumber : Number = Math.random();
			if(aNumber < 0.5){
				aNumber = 0;
			}else{
				aNumber = 1;
			}
			return int(aNumber);
		}
		
		/**
		 **/
//		public function randomize (anArray : Array) : int {
//			var aNumber : int = 0;
//			return aNumber;
//		}
		
		
		/**
		 * Randomly chooses the position of the bloxx
		 */
		public function chooseBloxxPos() : void{
			for(var i : int = 0; i < rowCount; i++){
				for(var j : int = 0; j < columnCount; j++){
					var temp : int = randomize();
					if(temp == 1){
						gridArray[i][j] = true; 
					}else{
						gridArray[i][j] = false;
					}
				}
			}
			trace(gridArray);
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
		 * Spawn Players.
		 **/
		public function spawnPlayers() : Player {
			playerOne = new Player("avatar_Yellow");
			return playerOne;
		}
		
		public function update(_event : Event) : void{
			checkItemColliderState();
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
					trace("remove Me");
					
					//remove the counter th Element from the Array (the 1 indicates: only 1 Element)
					HFUBloxx.itemColliderArray.splice(counter, 1);
				}
				counter++;
			}
		}
		
		
	}
}