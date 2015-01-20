package Screens
{
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class GameOver extends BloxxScreen
	{
		private var score : int;
		public function GameOver()
		{
			
			super();
			var bg:Image = new Image(Assets.getTexture("bg"));
			this.addChild(bg);
			
			var gameoverImg:Image = new Image(Assets.getTexture("gameover"));
			gameoverImg.x = HFUBloxx.screenWidth/2 - gameoverImg.width/2;
			gameoverImg.y = HFUBloxx.screenHeight/2 - gameoverImg.height/2;
			this.addChild(gameoverImg);
			
			/*var msg:Image = new Image(Assets.getTextue("copyright"));
			msg.x = 0;
			msg.y = 440;
			this.addChild(msg);
			
			var btn:Button = new Button(Assets.getTextue("menubtn"));
			btn.x = 345;
			btn.y = 330;
			this.addChild(btn);
			btn.addEventListener(Event.TRIGGERED, menuBtn_Click);
			*/
		}
		
		public function startNewGame() : void {
			
		}
	}
}