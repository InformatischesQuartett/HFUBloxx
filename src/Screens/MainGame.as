package Screens {
	
	import GameObjects.Player;
	
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	public class MainGame extends Sprite {
		
		/*Game Variables */
		private var colorBloxxArray : Array;
		private var colorHatPipeArray : Array;
		private var colorPlayerArray : Array;
		
		private var gameScore : int = 0;
		
		private var playerOne : Player;
		private var playerTwo : Player;

		public function MainGame() {
			//call super class' constructor
			super();
			
			trace("Starting MainGame");
			
			//initialize color-choice arrays, the strings are the same as in the Assets.as file
			colorBloxxArray = new Array("blue", "gray", "lightGreen", "darkGreen", "lilac", "orange", "red", "turquoise", "yellow");
		
			colorHatPipeArray = new Array("green", "pink", "yellow", "blue");
			
			colorPlayerArray = new Array("avatar_Yellow", "avatar_Voilet", "avatar_Red", "avatar_Green");

			//set background Texture of screen
			var bg : Image = new Image(Assets.getTexture("bg"));
			bg.width = HFUBloxx.GameWidth;
			bg.height = HFUBloxx.GameHeight;
			this.addChild(bg);
			
			//set background Texture of game
			var backgroundGame:Image = new Image(Assets.getTexture("bg_Game"));
			backgroundGame.width = HFUBloxx.GameWidth/2;
			backgroundGame.height = HFUBloxx.GameHeight;
			this.addChild(backgroundGame);
			
			//spawns player and adds him to main stage
			this.addChild(spawnPlayers());
		
		}//end constructor
		
		/**
		 **/
		public function randomize (anArray : Array) : int {
			var aNumber : int = 0;
			return aNumber;
		}
		
		//draw a bloxx according to random color and random shape
		public function drawBloxx() : void {
			
		}
		
		/**
		 * Spawn Players.
		 **/
		public function spawnPlayers() : Player {
			playerOne = new Player("avatar_Yellow");
			return playerOne;
		}
	}
}