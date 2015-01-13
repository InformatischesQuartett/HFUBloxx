package
{
	import flash.display.Sprite;
	import flash.events.GameInputEvent;
	import flash.ui.GameInput;
	import flash.ui.GameInputDevice;
	
	public class GameController extends Sprite
	{		
		public static var gameInput:GameInput = new GameInput();
		
		public function GameController()
		{
			if(GameInput.isSupported)
				trace("GameInput is supported! moving on...");
			else
				trace("GameInput is not supported!");
			
			var numDevices:uint;
			if ((numDevices = GameInput.numDevices) > 0)
			{
				var device:GameInputDevice;
				for (var i:uint = 0; i < numDevices; i++)
				{
					device = GameInput.getDeviceAt(i);
					if(device)
						trace("game input device found",device.name);
					else
						trace("wait... did gameInput get magically garbage collected?",gameInput? "no it's fine" : "yep it did.");
				}
			}
			else
				trace("there's no devices in the list yet.");
			
			gameInput.addEventListener(GameInputEvent.DEVICE_ADDED,function handleDeviceAdded(e:GameInputEvent):void
			{
				trace("game input device added",e.device.name);				
			});
			
			gameInput.addEventListener(GameInputEvent.DEVICE_REMOVED,function handleDeviceRemovedEvent(e:GameInputEvent):void
			{
				trace("game input device removed",e.device.name);
			});
			
		}

	}
}