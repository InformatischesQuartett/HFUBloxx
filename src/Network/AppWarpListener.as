package Network
{
	import com.shephertz.appwarp.WarpClient;
	import com.shephertz.appwarp.listener.ConnectionRequestListener;
	import com.shephertz.appwarp.listener.NotificationListener;
	import com.shephertz.appwarp.listener.RoomRequestListener;
	import com.shephertz.appwarp.messages.Chat;
	import com.shephertz.appwarp.messages.LiveRoom;
	import com.shephertz.appwarp.messages.Lobby;
	import com.shephertz.appwarp.messages.Move;
	import com.shephertz.appwarp.messages.Room;
	import com.shephertz.appwarp.types.ResultCode;
	
	import flash.utils.ByteArray;
	
	public class AppWarpListener implements ConnectionRequestListener, RoomRequestListener, NotificationListener
	{
		private var netHandler:NetworkHandler;
		
		public function AppWarpListener(net:NetworkHandler)
		{
			netHandler = net;
		}

		public function onConnectDone(res:int, reason:int):void
		{
			if (res == ResultCode.success){
				WarpClient.getInstance().joinRoom(netHandler.roomID);
				WarpClient.getInstance().subscribeRoom(netHandler.roomID);
			}
			else if (res == ResultCode.auth_error)
				netHandler.updateStatus("Auth Error");
			else if (res == ResultCode.connection_error)
				netHandler.updateStatus("Network Error. Check your internet connectivity and retry.");
			else
				netHandler.updateStatus("Unknown Error");
		}
		
		public function onDisConnectDone(res:int):void
		{
			// not implemented
		}
		
		public function onInitUDPDone(res:int):void
		{
			// not implemented
		}
		
		public function onSubscribeRoomDone(event:Room):void
		{
			// not implemented
		}
		
		public function onUnsubscribeRoomDone(event:Room):void
		{
			// not implemented
		}
		
		public function onJoinRoomDone(event:Room):void
		{
			if (event.result == ResultCode.success)
				netHandler.updateStatus("Started! Use up/down arrows and click to shoot.");
			else
				netHandler.updateStatus("Room join failed. Verify your room id.");
		}
		
		public function onLeaveRoomDone(event:Room):void
		{
			// not implemented
		}
		
		public function onGetLiveRoomInfoDone(event:LiveRoom):void
		{
			// not implemented
		}
		
		public function onSetCustomRoomDataDone(event:LiveRoom):void
		{
			// not implemented
		}
		
		public function onLockPropertiesDone(result:int):void
		{
			// not implemented
		}
		
		public function onUnlockPropertiesDone(result:int):void
		{
			// not implemented
		}
		
		public function onUpdatePropertiesDone(event:LiveRoom):void
		{
			// not implemented
		}
		
		public function onRoomCreated(event:Room):void
		{
			// not implemented
		}
		
		public function onRoomDestroyed(event:Room):void
		{
			// not implemented
		}
		
		public function onUserLeftRoom(event:Room, user:String):void
		{
			// not implemented
		}
		
		public function onUserJoinedRoom(event:Room, user:String):void
		{
			// not implemented
		}
		
		public function onUserResumed(roomid:String, isLobby:Boolean, username:String):void
		{
			// not implemented
		}
		
		public function onUserPaused(roomid:String, isLobby:Boolean, username:String):void
		{
			// not implemented	
		}
		
		public function onUserLeftLobby(event:Lobby, user:String):void
		{
			// not implemented
		}
		
		public function onUserJoinedLobby(event:Lobby, user:String):void
		{
			// not implemented
		}
		
		public function onPrivateChatReceived(sender:String, chat:String):void
		{
			// not implemented
		}
		
		public function onChatReceived(event:Chat):void
		{
			if(event.sender != netHandler.localUsername){
				var inArray:Array = event.chat.split(",");
				
				if (inArray[0] == "msg")
					netHandler.updateStatus(" new Message (" + inArray[1] + ")");
			}
		}
		
		public function onUpdatePeersReceived(update:ByteArray, fromUDP:Boolean):void
		{
			// not implemented
		}
		
		public function onUserChangeRoomProperties(room:Room, user:String, properties:Object, lockTable:Object):void
		{
			// not implemented
		}
		
		public function onMoveCompleted(moveEvent:Move):void
		{
			// not implemented
		}
		
		public function onGameStarted(sender:String, roomid:String, nextTurn:String):void
		{
			// not implemented	
		}
		
		public function onGameStopped(sender:String, roomid:String):void
		{
			// not implemented	
		}
		
		public function onPrivateUpdateReceived(sender:String, update:ByteArray, isUDP:Boolean):void
		{
			// not implemented	
		}
		
		public function onNextTurnRequest(lastTurn:String):void
		{
			// not implemented
		}
	}
}