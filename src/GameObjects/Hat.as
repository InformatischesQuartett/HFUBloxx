package GameObjects
{
	import starling.display.Image;
	import starling.display.Sprite;

	public class Hat extends Sprite
	{
		private var hatImage : Image;
		public var removeMe : Boolean;
		
		
		/**
		 * Constructor Hat
		 **/ 
		public function Hat()
		{	
			removeMe = false;
			hatImage = new Image(Assets.getTexture("hat_Green"));
			hatImage.height = HFUBloxx.playerSize *  0.7; // 70%
			hatImage.width = HFUBloxx.playerSize * 1.2;
			
			hatImage.x = (HFUBloxx.screenWidth/3);
			hatImage.y = (HFUBloxx.screenHeight - hatImage.height)- HFUBloxx.borderSize;
			this.addChild(hatImage);
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