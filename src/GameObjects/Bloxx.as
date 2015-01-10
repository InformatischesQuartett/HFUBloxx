package GameObjects {
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	/**
	 * This class describes the walls of the game, called "Bloxx"
	 **/
	public class Bloxx extends Sprite {
		
		private var bloxxSize : int = 16; //todo: set correct size
		private var bloxxImage : Image;
		private var posX : int;
		private var posY : int;
		
		
		/**
		 * Constructor of the Bloxx. It gets its position as arguments 
		 */
		public function Bloxx(posX : int, posY : int) {
			//image
			bloxxImage = new Image(Assets.getTexture("bloxx_White"));
			
			//position
			this.posX = posX;
			this.posY = posY;
			bloxxImage.x = posX;
			bloxxImage.y = posY;
			
			//adds Image to this stage
			this.addChild(bloxxImage);
		}
	}
}