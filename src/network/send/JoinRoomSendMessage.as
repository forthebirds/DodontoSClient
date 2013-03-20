package network.send 
{
	import network.ProtocolType;
	import network.restful.RESTRequestMethod;
	
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
			case ProtocolType.WebAPI: return null;
			default: return null;
			}
		}
		
		public function getWebAPIRelativeRequestAddress():String 
		{
			return "/room/" + mRoomID + "/login/" + mUserID;
		}
		
		public function getWebAPIHTTPRequestMethod( ) : RESTRequestMethod
		{
			return RESTRequestMethod.GET;
		}
		
		// ログイン対象のルームID
		private var mTargetRoomIndex : uint;
		
		private var mUserID : uint; // ユーザID
		private var mRoomID : uint; // ルームID
	}
}