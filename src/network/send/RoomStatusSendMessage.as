package network.send 
{
	// 部屋情報の獲得要求メッセージ
	public class RoomStatusSendMessage 
	{
		
		public function RoomStatusSendMessage() 
		{
		
		}
					
		// TODO: 以下のコードはLoginWindowから抽出したもの。適切に分解し、実装する
		/*
		Log.logging("LoginWindow.checkRoomStatusResult begin");
		try{
			enableLoginButton();
			
			var jsonData:Object = SharedDataReceiver.getJsonDataFromResultEvent(obj);
			
			var isRoomExist:Boolean = jsonData.isRoomExist;
			Log.logging("isRoomExist", isRoomExist);
			
			var roomNumber:int = jsonData.roomNumber;
			var roomName:String = jsonData.roomName;
			var chatChannelNames:Array = jsonData.chatChannelNames;
			var canUseExternalImage:Boolean = jsonData.canUseExternalImage;
			var canVisit:Boolean = jsonData.canVisit;
			var isPasswordLocked:Boolean = jsonData.isPasswordLocked;
			
			Log.logging("roomNumber", roomNumber);
			Log.logging("roomName", roomName);
			Log.logging("chatChannelNames", chatChannelNames);
			Log.logging("canUseExternalImage", canUseExternalImage);
			Log.logging("canVisit", canVisit);
			Log.logging("isPasswordLocked", isPasswordLocked);
			
			DodontoF_Main.getInstance().setMentenanceModeOn( jsonData.isMentenanceModeOn );
			DodontoF_Main.getInstance().setWelcomeMessageOn( jsonData.isWelcomeMessageOn );
			DodontoF_Main.getInstance().setUseExternalImage( canUseExternalImage );
			
			var enterPlayRoomFunction:Function = getEnterPlayRoomFunction(roomNumber, roomName, chatChannelNames);
			
			if( ! isRoomExist ) {
				var createPlayRoomWindow:CreatePlayRoomWindow = DodontoF.popup(CreatePlayRoomWindow, true) as CreatePlayRoomWindow;
				createPlayRoomWindow.initParams(roomNumber, isNeedCreatePassword, enterPlayRoomFunction);
				
				return;
			}
			
			//パスワード無しで見学無しならそのままログイン
			if( ! isPasswordLocked ) {
				if( ! canVisit ) {
					enterPlayRoomFunction();
					return;
				}
			}
			
			//パスワードか見学ありの場合
			var window:InputPlayRoomPasswordWindow = DodontoF.popup(InputPlayRoomPasswordWindow, true) as InputPlayRoomPasswordWindow;
			window.init(roomNumber, roomName, canVisit, isPasswordLocked, enterPlayRoomFunction);
		} catch(error:Error)
		{
			status = error.message;
		}
		*/
	}

}