package {
	
	import Screens.MainMenu;
	import starling.display.Sprite;

	public class BloxxGame extends Sprite {

		public function BloxxGame() {
			// calls constructor of super class
			super();
			
			var mainMenu : Sprite = new MainMenu();
			this.addChild(mainMenu);
		}
	}
}
