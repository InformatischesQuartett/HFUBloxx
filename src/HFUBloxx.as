package
{
	
	//import flash.display.MovieClip;
	//import engine libs
	import flash.display.Sprite;
	import starling.core.Starling;
	import flash.system.Capabilities;
	
	//settings
	[SWF(frameRate="60", width="800", height="600")]
	
	/**
	 This is the main document class of the game HFUBloxx.
	 Authors: Fabian Gärtner, Ramo Gündogdu, Sarah Häfele
	 Assets: Sandra Beuck
	 Concept: Sandra Beuck, Felix Eckerle, Felix Prosch
	 
	 Developed for the class Interaction Design for DIM and MIM at Hochschule Furtwangen University in 2014.
	 **/
	public class HFUBloxx extends Sprite {
		
		private var myStarling:Starling;
		public static var GameHeight:int;
		public static var GameWidth:int;
		
		public function HFUBloxx() {
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