package GameObjects
{
	import flash.events.Event;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class Pipe extends Sprite
	{
		private var pipeImage : Image;
		public var removeMe : Boolean;
		public var pipeSpeed : int;
		public var colorAttribute : String;
		
		public function Pipe(pipeColor : String, currPipeNumber : int)
		{
			//set up event listener which is called per frame
			Starling.current.nativeStage.addEventListener(Event.ENTER_FRAME, update);
						
			removeMe = false;
			pipeImage = new Image(Assets.getTexture("pipe_" + pipeColor));
			pipeImage.height = HFUBloxx.playerSize;
			pipeImage.width = (HFUBloxx.screenWidth/2 - HFUBloxx.borderSize);
			
			pipeImage.x = HFUBloxx.borderSize/2;
			pipeImage.y = HFUBloxx.borderSize;
			this.addChild(pipeImage);
			
			colorAttribute = pipeColor;
			
			pipeSpeed = 1 + currPipeNumber;
		}
		
		public function update (_event : Event) : void {
			if (!removeMe) {
				moveMe ();
			}  else {
				this.removeChild(pipeImage);
			}
		}
		
		/**
		 * sets the state of the pipe
		 **/ 
		public function setRemoveMe  (pipeDeleteState : Boolean) : void {
			removeMe = pipeDeleteState;
		}
		
		private function moveMe () : void {
			this.y += pipeSpeed;
		}
	}
}