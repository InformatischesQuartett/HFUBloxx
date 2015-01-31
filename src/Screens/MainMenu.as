package Screens
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	
	import Network.NetworkHandler;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	
	public class MainMenu extends BloxxScreen
	{		
		public function MainMenu()
		{
			super(null);

			var bg : Image = new Image(Assets.getTexture("bg"));
			bg.width = HFUBloxx.screenWidth;
			bg.height = HFUBloxx.screenHeight;
			this.addChild(bg);
			
			var playButton : Button = new Button(Assets.getTexture("play_Button"));
			playButton.scaleX = 0.7;
			playButton.scaleY = 0.7;
			playButton.x = HFUBloxx.screenWidth * 0.55;
			playButton.y = HFUBloxx.screenHeight * 0.45;
			this.addChild(playButton);
			playButton.addEventListener(Event.TRIGGERED, plyBtn_onClick);
			
			
			
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
			gameHandler.loadScreen(MainGame)
		}
	}
}