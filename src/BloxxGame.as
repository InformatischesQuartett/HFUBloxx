package {
	
	import Screens.Menu;
	
	import starling.display.Sprite;
	import starling.core.Starling;
	
	public class BloxxGame extends Sprite {

		public function BloxxGame() {
			// constructor code
			//calls constructor of super class
			super();
			
			var myMenu : Sprite = new Menu();
			this.addChild(myMenu);
			
		}

	}
	
}
