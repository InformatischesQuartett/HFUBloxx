package Screens
{
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Menu extends Sprite
	{
		//public var himanshu:App42LeaderBoard;	
		
		public function Menu()
		{
			super();

			var bg : Image = new Image(Assets.getTexture("bg"));
			bg.width = HFUBloxx.GameWidth;
			bg.height = HFUBloxx.GameHeight;
			this.addChild(bg);
			
			var playButton : Button = new Button(Assets.getTexture("play_Button"));
			playButton.x = HFUBloxx.GameWidth/3;
			playButton.y = 250;
			this.addChild(playButton);
			playButton.addEventListener(Event.TRIGGERED, plyBtn_onClick);
			
			var scoreButton : Button = new Button(Assets.getTexture("y_Button"));
			scoreButton.width = 100;
			scoreButton.height = 100;
			scoreButton.x = (playButton.x + playButton.width) + 10;
			scoreButton.y = (playButton.y);
			this.addChild(scoreButton);
			
			
			/*
			var logo:Image = new Image(Assets.getTextue("logo"));
			logo.x = 85;
			logo.y = 50;
			this.addChild(logo);
			
			var btn:Button = new Button(Assets.getTextue("playBtn"));
			btn.x = 336;
			btn.y = 250;
			this.addChild(btn);
			btn.addEventListener(Event.TRIGGERED, plyBtn_Click);
			
			var userScore:Button = new Button(Assets.getTextue("leaderboard"));
			userScore.x = 310;
			userScore.y = 340;
			this.addChild(userScore);
			userScore.addEventListener(Event.TRIGGERED, userScore_Click);
			
			
			var msg:Image = new Image(Assets.getTextue("copyright"));
			msg.x = 0;
			msg.y = 440;
			this.addChild(msg);
			*/
		}
		
		public function plyBtn_onClick(event:Event):void
		{
			var screen:Sprite = new SinglePlayer();
			this.parent.addChild(screen);
			this.removeFromParent(true);
		}
		
		public function userScore_onClick(event:Event):void
		{
			/*
			var screen:Sprite = new App42LeaderBoard();
			this.parent.addChild(screen);
			this.removeFromParent(true);
			*/
		}
	}
}