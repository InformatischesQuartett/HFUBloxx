package Ouya.Control {
	import flash.ui.GameInputControl;
	
	import Ouya.Controller.GameController;
	
	public class TriggerControl extends ButtonControl {
		public function TriggerControl(device:GameController, control:GameInputControl) {
			super(device, control);
		}
		
		public function get distance():Number {
			return value;
		}
	}
}