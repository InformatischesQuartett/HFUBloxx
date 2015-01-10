package GameObjects {
	
	import starling.display.Image;
	import starling.display.Sprite;
	
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
			
			//position
			bloxxImage.x = posX;
			bloxxImage.y = posY;
			
			//adds Image to this stage
			this.addChild(bloxxImage);
		}
	}
}