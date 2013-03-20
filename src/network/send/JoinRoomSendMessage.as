package network.send 
{
	import network.ProtocolType;
	public class JoinRoomSendMessage implements ISendMessage
	{
		// @param userID あるルームに参加するユーザのユーザID。それはあなたです！
		// @param roomID 参加する対象のルームインデクス
		public function JoinRoomSendMessage( userID : uint, roomID : uint )
		{
			mUserID = userID;
			mRoomID = roomID;
		}
		
		// ----------------------------- ISendMessageから実装

		public function getMessageOnHTTPPollingStrategy(protocol:ProtocolType):Object 
		{
			switch( protocol )
			{
			case ProtocolType.WebAPI:
				return createMessageObject( );
			default: return null;
			}
		}
		
		public function getWebAPIRelativeRequestAddress():String 
		{
			return "/room/login";
		}
		
		private createMessageObject( ) : Object
		{
			var message : Object = new Object( );
			message[ "UserID" ] = mUserID;
			message[ "RoomID" ] = mRoomID;
			
			return message;
		}
		
		// ログイン対象のルームID
		private var mTargetRoomIndex : uint;
	}
}