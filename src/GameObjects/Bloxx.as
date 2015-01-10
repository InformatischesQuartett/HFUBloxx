package GameObjects {
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	/**
	 * This class describes the walls of the game, called "Bloxx"
	 **/
	public class Bloxx extends Sprite {
		
		private var bloxxSize : int = 16; //todo: set correct size
		private var bloxxImage : Image;
		private var posX : int;
		private var posY : int;
		
		
<<<<<<< HEAD
		/**
		 * Constructor of the Bloxx. It gets its position as arguments 
		 */
		public function Bloxx(posX : int, posY : int) {
			//image
			bloxxImage = new Image(Assets.getTexture("bloxx_White"));
			
			bloxxImage.scaleX = 0.1;
			bloxxImage.scaleY = 0.1;
			
			//position
			bloxxImage.x = posX;
			bloxxImage.y = posY;
			
			
			
			//adds Image to this stage
			this.addChild(bloxxImage);
=======
		public function Bloxx() {
			////todo: make switch case/ or use array for different textures
			//bloxxImage = new Image(Assets.getTexture("");
>>>>>>> origin/master
		}
	}
}