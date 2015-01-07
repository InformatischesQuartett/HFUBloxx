package
{
	//import flash.display.MovieClip;
	//import engine libs
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.Capabilities;
	import flash.ui.Keyboard;
	
	import Network.NetworkHandler;
	
	import Screens.MainGame;
	import Screens.MainMenu;
	
	import Webcam.CamHandler;
	
	import starling.core.Starling;
	import starling.events.Event;
	import Screens.BloxxScreen;
	
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
		
		//engine and network
		private var mStarling : Starling;
		
		private var camHandler : CamHandler;
		private var netHandler : NetworkHandler;
		
		private var curScreen : BloxxScreen;
		
		//stores the external data
		public var xmlContent : XML;
		public var ldr : URLLoader;
		
		//basic config variables --> source: external XML file
		public static var GameHeight : int;
		public static var GameWidth : int;
		public static var playerSize : int;
		public static var borderSize : int;
		
		//variables for keyboard input
		public static var up : Boolean = false;
		public static var down : Boolean = false;
		public static var left : Boolean = false;
		public static var right : Boolean = false;
		
		private var keysDown:Array = new Array(256);
		
		//Array of colider references
		public static var colliderArray : Array = new Array();
		
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
			mStarling = new Starling(MainMenu, stage);
			
			mStarling.addEventListener(starling.events.Event.ROOT_CREATED, function():void
			{
				initStarling();
			});
			
			mStarling.start();
		} // end of constructor
		
		private function initStarling(): void
		{
			// adding the event listeners
			mStarling.nativeStage.addEventListener(KeyboardEvent.KEY_DOWN, onKeysDown);
			mStarling.nativeStage.addEventListener(KeyboardEvent.KEY_UP, onKeysUp);
			
			// init camera manager
			camHandler = new CamHandler();
			mStarling.stage.addChild(camHandler);
			
			camHandler.setLocalImage(new Rectangle(5, 30, 200, 200), false);
			camHandler.setRemoteImage(new Rectangle(210, 30, 200, 200), false);

			camHandler.attachCamera();
			
			camHandler.setLocalVisibility(true);
			camHandler.setRemoteVisibility(true);
			
			// start network manager
			netHandler = new NetworkHandler();
			netHandler.setCamHandler(camHandler);
			mStarling.stage.addChild(netHandler);
			
			// set root handler
			curScreen = (mStarling.root as MainMenu);
			curScreen.setHandler(this, netHandler);
		}
		
		public function loadScreen(screenCl:Class): void
		{
			// delete current screen
			mStarling.stage.removeChild(curScreen);
			curScreen = null;
			
			// create new screen
			var screen:BloxxScreen = new screenCl();
			screen.setHandler(this, netHandler);
			
			mStarling.stage.addChild(screen);
			mStarling.stage.setChildIndex(screen, 0);
			
			curScreen = screen;
			
			// specific screen settings
			switch (screenCl)
			{
				case MainGame:
				{
					camHandler.setLocalVisibility(false);
					camHandler.setRemoteImage(new Rectangle(505, 375, 200, 200));
					
					break;
				}
			}
		}
		
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
			ldr.addEventListener(flash.events.Event.COMPLETE, loadComplete);
			ldr.addEventListener(IOErrorEvent.IO_ERROR, loadError);
			
			ldr.load(new URLRequest("./externalData.xml"));
		}
		
		/**
		 * When loading complete, store data in variable and remove listeners
		 **/
		public function loadComplete(_event : flash.events.Event) : void {
			xmlContent = new XML(ldr.data);
			ldr.removeEventListener(flash.events.Event.COMPLETE, loadComplete);
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
			keysDown[_event.keyCode] = true;
			
			switch(_event.keyCode) {
				case Keyboard.UP:
				case Keyboard.SPACE:
					up = true;
					break;
				case Keyboard.A:
				case Keyboard.LEFT:
					left = true;
					right = false;
					break;
				case Keyboard.D:
				case Keyboard.RIGHT:
					right = true;
					left = false;
					break;
			}
		}
		
		/**
		 * Event handler when keys are released
		 **/
		public function onKeysUp(_event : KeyboardEvent) : void {
			keysDown[_event.keyCode] = false;
			
			switch(_event.keyCode) {
				case Keyboard.UP:
				case Keyboard.SPACE:
					up = false;
					break;
				case Keyboard.A:
				case Keyboard.LEFT:
					left = false;
					right = keysDown[Keyboard.D] || keysDown[Keyboard.RIGHT];
					break;
				case Keyboard.D:
				case Keyboard.RIGHT:
					right = false;
					left = keysDown[Keyboard.A] || keysDown[Keyboard.LEFT];
					break;
			}
		}
		
		/**
		 * 
		 * register coliders for collision checking
		 * */
		public static function registerCollider(aObject:Object) : void{
			colliderArray.push(aObject); 	
			trace(aObject);
		}
		
	} //end class
} //end package