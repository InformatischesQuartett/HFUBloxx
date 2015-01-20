package GameObjects
{
	import Screens.MainGame;
	
	import starling.display.Image;
	import starling.display.Sprite;

	public class Hat extends Sprite
	{
		private var hatImage : Image;
		public var removeMe : Boolean;
		public var colorAttribute : String;
		
		
		/**
		 * Constructor Hat
		 **/ 
		public function Hat(hatColor : String, posX : int, posY : int)
		{	
			removeMe = false;
			hatImage = new Image(Assets.getTexture("hat_" + hatColor));
			hatImage.height = HFUBloxx.playerSize *  0.9; // 70%
			hatImage.width = HFUBloxx.playerSize * 1.5;
			
			this.x = posX * ((HFUBloxx.screenWidth/2) / MainGame.getColumnCount()) - 5;
			this.y = posY * ((HFUBloxx.screenHeight) / MainGame.getRowCount())  + 20;
			this.addChild(hatImage);
			colorAttribute = hatColor;
			
			HFUBloxx.registerItemCollider(this);
		}
		
		/**
		 * sets the state of the hat item
		 **/ 
		public function setRemoveMe  (hatDeleteState : Boolean) : void {
			removeMe = hatDeleteState;
		}
		
	}
}