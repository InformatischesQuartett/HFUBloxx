package Screens
{
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.media.SoundChannel;
	
	public class MainMenu extends BloxxScreen
	{	
		public var gameSound:Sound = new Sound();
		public var gameChannel:SoundChannel = new SoundChannel();
		
		public function MainMenu()
		{
			super();

			var bg : Image = new Image(Assets.getTexture("bg"));
			bg.width = HFUBloxx.screenWidth;
			bg.height = HFUBloxx.screenHeight;
			this.addChild(bg);
			
			var playButton : Button = new Button(Assets.getTexture("play_Button"));
			playButton.x = HFUBloxx.screenWidth/3;
			playButton.y = 250;
			this.addChild(playButton);
			playButton.addEventListener(Event.TRIGGERED, plyBtn_onClick);
			
			var scoreButton : Button = new Button(Assets.getTexture("y_Button"));
			scoreButton.width = 100;
			scoreButton.height = 100;
			scoreButton.x = (playButton.x + playButton.width) + 10;
			scoreButton.y = (playButton.y);
			this.addChild(scoreButton);
			scoreButton.addEventListener(Event.TRIGGERED, userScore_onClick);
			
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
			
		/**
		 * Listener Event for clicking the Play Button
		 * By clicking the game will start.
		 **/
		public function plyBtn_onClick(event:Event):void
		{			
			gameSound.load(new URLRequest("gameSound.mp3"));
			
			gameHandler.loadScreen(MainGame)
			gameChannel = gameSound.play();
		}
		
		public function userScore_onClick(event:Event):void
		{
			netHandler.sendMessage("msg", "this is a test");
		}
	}
}