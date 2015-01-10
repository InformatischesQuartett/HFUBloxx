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
		
		private var bloxxSize : int = 10;
		
		// Determines how many Bloxx fit in one line
		private var verticalGrids : int = 6;
		private var horizontalGrids : int = 10;
		
		// 2D-Array
		private var gridArray : Array;
		
		

		public function MainGame() {
			//call super class' constructor
			super();
			
			Starling.current.nativeStage.addEventListener(Event.ENTER_FRAME, update);
			
			trace("Starting MainGame");
			
			//initialize color-choice arrays, the strings are the same as in the Assets.as file
			colorBloxxArray = new Array("blue", "gray", "lightGreen", "darkGreen", "lilac", "orange", "red", "turquoise", "yellow");
		
			colorHatPipeArray = new Array("green", "pink", "yellow", "blue");
			
			colorPlayerArray = new Array("avatar_Yellow", "avatar_Voilet", "avatar_Red", "avatar_Green");
			
			//gridArray		
			gridArray = new Array();

			for(var i : int = 0; i < horizontalGrids; i++){
				gridArray[i] = [false,false,false,false,false,false];
				trace("At array pos " + i + " the horizontal array is: " + gridArray[i]);
			}
			
				
			//set background Texture of screen
			var bg : Image = new Image(Assets.getTexture("bg"));
			bg.width = HFUBloxx.GameWidth;
			bg.height = HFUBloxx.GameHeight;
			this.addChild(bg);
			
			//set background Texture of game
			backgroundGame = new Image(Assets.getTexture("bg_Game"));
			backgroundGame.width = HFUBloxx.GameWidth/2;
			backgroundGame.height = HFUBloxx.GameHeight;
			this.addChild(backgroundGame);
			
			chooseWallPos();
			drawBloxx();
			//buildWalls();
			
			//spawns player and adds him to main stage
			testHat = new Hat();
			this.addChild(testHat);
			this.addChild(spawnPlayers());
			
		
		}//end constructor
		
		/**
		 * returns either 1 or 0
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
		
		//draw a bloxx according to random color and random shape
		public function drawBloxx() : void {
			for(var i : int = 0; i < bloxxSize; i++){
				for(var j : int = 0; j < bloxxSize; j++){
					if(gridArray[i][j] == true){
						trace("BuildWall");
						var aBloxx : Bloxx = new Bloxx(bloxxSize * (j + 1), bloxxSize * (i + 1));
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
			checkColliderState();
		}
		
		public function checkColliderState() : void{
			// control variable for Array Elements
			var counter : int = 0;
			
			for each (var aCollider:* in HFUBloxx.colliderArray){
				if(aCollider.removeMe == true){
					this.removeChild(aCollider);
					trace("remove Me");
					
					//remove the counter th Element from the Array (the 1 indicates: only 1 Element)
					HFUBloxx.colliderArray.splice(counter, 1);
				}
				counter++;
			}
		}
		
		public function chooseWallPos() : void{
			for(var i : int = 0; i < horizontalGrids; i++){
				for(var j : int = 0; j < verticalGrids; j++){
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
		
		public function buildWalls() : void{
		}
		
		public function registerWallAsColliders() : void{
		}
		
	}
}