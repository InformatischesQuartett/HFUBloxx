package src {
	
	import flash.display.MovieClip;
	//import engine libs
	import flash.display.Sprite;
	import starling.core.Starling;
	
	//settings
	[SWF(frameRate="60", width="800", height="480")]
	
	/**
		This is the main document class of the game HFUBloxx.
		Authors: Fabian Gärtner, Ramo Gündogdu, Sarah Häfele
		Assets: Sandra Beuck
		Concept: Sandra Beuck, Felix Eckerle, Felix Prosch
		
		Developed for the class Interaction Design for DIM and MIM at Hochschule Furtwangen University in 2014.
	**/
	public class DocumentClass extends MovieClip {
		
		private var myStarling:Starling;
		
		public function DocumentClass() {
			//start game engine
			myStarling = new Starling(BloxxGame, stage);
			myStarling.antiAliasing = 2;
			myStarling.start();
		}
	}
	
}
