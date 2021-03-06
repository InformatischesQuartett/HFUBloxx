﻿package
{
	import flash.utils.Dictionary;
	import starling.textures.Texture;
	
	public class Assets
	{
		// Configurational Data from external Data file
		public var xmlContent : XML;
		
		
		// Game
		
		[Embed(source="../assets/textures/hfu-Bloxx_Screendesign.png")]
		public static const bg:Class;
		
		[Embed(source="../assets/textures/hg_Bloxx.png")]
		public static const bg_Game:Class;
		
		
		// Buttons
		
		[Embed(source="../assets/textures/play_button.png")]
		public static const play_Button:Class;
		
		[Embed(source="../assets/textures/button_x.png")]
		public static const y_Button:Class;
		
		[Embed(source="../assets/textures/button_left.png")]
		public static const left_Button:Class;
		
		[Embed(source="../assets/textures/button_right.png")]
		public static const right_Button:Class;
		
		[Embed(source="../assets/textures/button_controller.png")]
		public static const controller_Button:Class;
		
		[Embed(source="../assets/textures/button_herz.png")]
		public static const herz_Button:Class;
		
		[Embed(source="../assets/textures/button_time.png")]
		public static const time_Button:Class;
			
		
		// Spieliguren
		
		[Embed(source="../assets/textures/avatar_gre.png")]
		public static const avatar_Green:Class;
		
		[Embed(source="../assets/textures/avatar_red.png")]
		public static const avatar_Red:Class;
		
		[Embed(source="../assets/textures/avatar_yel.png")]
		public static const avatar_Yellow:Class;
		
		[Embed(source="../assets/textures/avatar_ora.png")]
		public static const avatar_Orange:Class;
		
		
		// BloXX
		
		[Embed(source="../assets/textures/bloxx_white.png")]
		public static const bloxx_White:Class;
		
		// Pipes
		[Embed(source="../assets/textures/pipe_blue.png")]
		public static const pipe_Blue:Class;
		
		[Embed(source="../assets/textures/pipe_green.png")]
		public static const pipe_Green:Class;
		
		[Embed(source="../assets/textures/pipe_orange.png")]
		public static const pipe_Orange:Class;
		
		[Embed(source="../assets/textures/pipe_pink.png")]
		public static const pipe_Pink:Class;
		
		[Embed(source="../assets/textures/pipe_red.png")]
		public static const pipe_Red:Class;
		
		[Embed(source="../assets/textures/pipe_yellow.png")]
		public static const pipe_Yellow:Class;
		
		// Hüte
		
		[Embed(source="../assets/textures/hat_blue.png")]
		public static const hat_Blue:Class;
		
		[Embed(source="../assets/textures/hat_green.png")]
		public static const hat_Green:Class;
		
		[Embed(source="../assets/textures/hat_orange.png")]
		public static const hat_Orange:Class;
		
		[Embed(source="../assets/textures/hat_pink.png")]
		public static const hat_Pink:Class;
		
		[Embed(source="../assets/textures/hat_red.png")]
		public static const hat_Red:Class;
		
		[Embed(source="../assets/textures/hat_yellow.png")]
		public static const hat_Yellow:Class;
				
		
		// Misc
		
		[Embed(source="../assets/textures/person.jpg")]
		public static const misc_Person:Class;		
		
		[Embed(source="../assets/textures/font_game_over.png")]
		public static const gameover:Class;
		
		
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
		
		public static function getTexture(name:String, width:int=0, height:int=0):Texture
		{
			if(gameTextures[name] == undefined)
			{
				if (Assets[name] != undefined)
					gameTextures[name] = Texture.fromEmbeddedAsset(Assets[name]);
				else
					throw new Error("Could not find variable '" + name + "'. Has it been declared?"); 
			}
			
			return gameTextures[name];
		}
	}
}