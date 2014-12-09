package
{
	
	//import flash.display.MovieClip;
	//import engine libs
	import flash.display.Sprite;
	import flash.system.Capabilities;
	
	import starling.core.Starling;
	
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.events.IOErrorEvent;
	
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.ui.Keyboard;
	
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
		
		//engine
		private var myStarling : Starling;
		
		//stores the external data
		public var xmlContent : XML;
		public var ldr : URLLoader;
		
		//basic config variables --> source: external XML file
		public static var GameHeight : int;
		public static var GameWidth : int;
		public static var playerSize : int;
		public static var borderSize : int;
		
		//variables for keyboard input
		public var up : Boolean = false;
		public var down : Boolean = false;
		public var left : Boolean = false;
		public var right : Boolean = false;
		
		public function HFUBloxx() {
			//loading external data
			loadData();
			
			/*Game Configuration --> put these parameters in an external file*/
			//defines the image size of the ghost avatar
			playerSize = 40;
			//describes the size of the black border stroke from the gamescreen
			borderSize = 20;
			//set the screen resolution
			GameWidth = 800; //int(xmlContent.Display.gameWidth.@gw);//800; //Capabilities.screenResolutionX;
			GameHeight = 600; //Capabilities.screenResolutionY;
			
			//start game engine
			myStarling = new Starling(BloxxGame, stage);
			myStarling.antiAliasing = 2;
			myStarling.start();
			
			//adding the event listeners
			Starling.current.nativeStage.addEventListener(KeyboardEvent.KEY_DOWN, onKeysDown);
			Starling.current.nativeStage.addEventListener(KeyboardEvent.KEY_UP, onKeysUp);
				
		}//end constructor
		
		
		/**
		 * ------------------------------------------------------------
		 * Handling External Data
		 * ------------------------------------------------------------
		 **/ 
		
		/**
		 * Load external XML data for configuration without building new
		 **/
		public function loadData() : void {
			ldr = new URLLoader();
			ldr.addEventListener(Event.COMPLETE, loadComplete);
			ldr.addEventListener(IOErrorEvent.IO_ERROR, loadError);
			
			ldr.load(new URLRequest("./externalData.xml"));
		}
		
		/**
		 * When loading complete, store data in variable and remove listeners
		 **/
		public function loadComplete(_event : Event) : void {
			xmlContent = new XML(ldr.data);
			ldr.removeEventListener(Event.COMPLETE, loadComplete);
			ldr.removeEventListener(IOErrorEvent.IO_ERROR, loadError);
			trace("Loading from external data completed");
		}
		
		/**
		 * Set default values if external Data can't be loaded.
		 **/
		public function loadError(_event : IOErrorEvent) : void {
			trace("There has been an error while loading from external data.");
		}
		
		
		/**
		 * ------------------------------------------------------------
		 * Keyboard Controls for Development
		 * ------------------------------------------------------------
		 **/ 
		
		/**
		 * Event handler when keys are pressed down
		 **/
		public function onKeysDown(_event : KeyboardEvent) : void {
			switch(_event.keyCode) {
				case Keyboard.SPACE:
					trace("I am jumping");
					up = true;
					break;
				case Keyboard.A:
				case Keyboard.LEFT:
					left = true;
					break;
				case Keyboard.D:
				case Keyboard.RIGHT:
					right = true;
					break;
			}
		}
		
		/**
		 * Event handler when keys are released
		 **/
		public function onKeysUp(_event : KeyboardEvent) : void {
			switch(_event.keyCode) {
				case Keyboard.SPACE:
					up = false;
					break;
				case Keyboard.A:
				case Keyboard.LEFT:
					left = false;
					break;
				case Keyboard.D:
				case Keyboard.RIGHT:
					right = false;
					break;
			}
		}
		
	} //end class
} //end package