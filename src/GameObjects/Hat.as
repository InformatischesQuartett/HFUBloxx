package GameObjects
{
	import flash.display.Sprite;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;

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
			
			hatImage.x = (HFUBloxx.GameWidth/3);
			hatImage.y = (HFUBloxx.GameHeight - hatImage.height)- HFUBloxx.borderSize;
			this.addChild(hatImage);
			HFUBloxx.registerCollider(this);
		}
		
		public function setRemoveMe  (hatDeleteState : Boolean) : void {
			removeMe = hatDeleteState;
		}
		
	}
}