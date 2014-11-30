package
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;

	public class Assets
	{
		[Embed(source="../assets/textures/hfu-Bloxx_Screendesign.png")]
		public static const bg:Class;
		
		[Embed(source="../assets/textures/play_button.png")]
		public static const play_Button:Class;
		
		[Embed(source="../assets/textures/y_button.png")]
		public static const y_Button:Class;
		
		[Embed(source="../assets/textures/left_button.png")]
		public static const left_Button:Class;
		
		[Embed(source="../assets/textures/right_button.png")]
		public static const right_Button:Class;
		
		
		
		
		/*
		[Embed(source="../assets/images/logo.png")]
		public static const logo:Class;
		
		[Embed(source="../assets/images/plybtn.png")]
		public static const playBtn:Class;
		
		[Embed(source="../assets/images/leaderboard.png")]
		public static const leaderboard:Class;
		
		[Embed(source="../assets/images/copyright.png")]
		public static const copyright:Class;
		
		[Embed(source="../assets/images/bg.png")]
		public static const bg:Class;
		
		[Embed(source="../assets/images/block.png")]
		public static const block:Class;
		
		[Embed(source="../assets/images/block2.png")]
		public static const block2:Class;
		
		[Embed(source="../assets/images/gameover.png")]
		public static const gameover:Class;
		
		[Embed(source="../assets/images/win.png")]
		public static const youwin:Class;
		
		[Embed(source="../assets/images/menubtn.png")]
		public static const menubtn:Class;
		
		
		[Embed(source="../assets/images/GetLastScoreOfUser.png")]
		public static const GetLastScoreOfUser:Class;
		
		[Embed(source="../assets/images/GetTopRewardEarner.png")]
		public static const GetTopRewardEarner:Class;
		
		[Embed(source="../assets/images/GetTopScorer.png")]
		public static const GetTopScorer:Class;
		
		[Embed(source="../assets/images/header.png")]
		public static const header:Class;
		
		*/
		
		private static var gameTextures:Dictionary = new Dictionary();
		
		public static function getTexture(name:String):Texture
		{
			if(gameTextures[name] == undefined)
			{
				var bitmap:Bitmap = new Assets[name]();
				gameTextures[name] = Texture.fromBitmap(bitmap);
			}
			
			return gameTextures[name];
		}
	}
}