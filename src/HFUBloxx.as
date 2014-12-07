package
{
	
	//import flash.display.MovieClip;
	//import engine libs
	import flash.display.Sprite;
	import flash.system.Capabilities;
	
	import starling.core.Starling;
	
	//settings
	[SWF(frameRate="60", width="800", height="600")]
	
	/**
	 This is the main document class of the game HFUBloxx.
	 It includes the main config of the game.
	 Authors: Fabian Gärtner, Ramo Gündogdu, Sarah Häfele
	 Assets: Sandra Beuck
	 Concept: Sandra Beuck, Felix Eckerle, Felix Prosch
	 
	 Developed for the class Interaction Design for DIM and MIM at Hochschule Furtwangen University in 2014.
	 **/
	public class HFUBloxx extends Sprite {
		
		private var myStarling:Starling;
		public static var GameHeight:int;
		public static var GameWidth:int;
		public static var playerSize : int;
		public static var borderSize : int;
		
		public function HFUBloxx() {
			/*Game Configuration */
			//defines the image size of the ghost avatar
			playerSize = 40;
			//describes the size of the black border stroke from the gamescreen
			borderSize = 20;
			//set the screen resolution
			GameWidth = 800; //Capabilities.screenResolutionX;
			GameHeight = 600; //Capabilities.screenResolutionY;

			//start game engine
			myStarling = new Starling(BloxxGame, stage);
			myStarling.antiAliasing = 2;
			myStarling.start();
			
			
		}
	}
}