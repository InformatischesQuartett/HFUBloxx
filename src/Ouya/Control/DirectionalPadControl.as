package Ouya.Control {
	import flash.ui.GameInputControl;
	
	import Ouya.Controller.GameController;
	
	public class DirectionalPadControl {
		public var up:ButtonControl;
		public var down:ButtonControl;
		public var left:ButtonControl;
		public var right:ButtonControl;
		
		public function DirectionalPadControl(device:GameController, up:GameInputControl, down:GameInputControl, left:GameInputControl, right:GameInputControl) {
			this.up = new ButtonControl(device, up);
			this.down = new ButtonControl(device, down);
			this.left = new ButtonControl(device, left);
			this.right = new ButtonControl(device, right);
		}
		
		public function reset():void {
			up.reset();
			down.reset();
			left.reset();
			right.reset();
		}
	}
}