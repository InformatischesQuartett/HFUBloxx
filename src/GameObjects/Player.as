package GameObjects {
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	public class Player extends Sprite {
		public function Player() {
			super();
			var bg : Image = new Image(Assets.getTexture("bg"));
			bg.width = HFUBloxx.GameWidth;
			bg.height = HFUBloxx.GameHeight;
			this.addChild(bg);
			
			var backgroundGame:Image = new Image(Assets.getTexture("bg_Game"));
			backgroundGame.width = HFUBloxx.GameWidth/2;
			backgroundGame.height = HFUBloxx.GameHeight;
			this.addChild(backgroundGame);
		}
	}
}