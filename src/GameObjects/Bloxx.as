package GameObjects {
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	import Screens.MainGame;
	
	/**
	 * This class describes the walls of the game, called "Bloxx"
	 **/
	public class Bloxx extends Sprite {
		
		private var bloxxSize : int = 16; //todo: set correct size
		private var bloxxImage : Image;
		
		/**
		 * Constructor of the Bloxx. It gets its position as arguments 
		 */
		public function Bloxx(posX : int, posY : int) {
			//image
			bloxxImage = new Image(Assets.getTexture("bloxx_White"));
			
			// size (determined by the game size devided through the respective gridCount)
			bloxxImage.width = (HFUBloxx.screenWidth/2) / MainGame.getColumnCount();
			bloxxImage.height = (HFUBloxx.screenHeight) / MainGame.getRowCount(); 
			
			//position
			bloxxImage.x = posX * bloxxImage.width ;
			bloxxImage.y = posY * bloxxImage.height;
			
			//adds Image to this stage
			this.addChild(bloxxImage);
			HFUBloxx.registerWallCollider(this);
		}
	}
}