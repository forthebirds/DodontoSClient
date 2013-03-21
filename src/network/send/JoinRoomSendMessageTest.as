package network.send
{
	import org.flexunit.Assert;

	import network.ProtocolType;
	import network.restful.RESTRequestMethod;
	
	public class JoinRoomSendMessageTest
	{
		//  正しいRelativeRequestAddressが生成されているかのテスト
		[Test]
		public function getWebAPIRelativeRequestAddressTest( ) : void
		{
			const userid : uint = 100;
			const roomid : uint = 20;
			var target : JoinRoomSendMessage = new JoinRoomSendMessage( userid, roomid );

			// "/room/:userid/login/:roomid"がリクエストの定義
			const expected : String = "/room/" + roomid + "/login/" + userid;

			Assert.assertEquals( expected, target.getWebAPIRelativeRequestAddress( ) );
		}

		//  正しいRelativeRequestAddressが生成されているかのテスト
		[Test]
		public function getWebAPIHTTPRequestMethodTest( ) : void
		{
			var target : JoinRoomSendMessage = new JoinRoomSendMessage( 0, 0 );
			const expected : RESTRequestMethod = RESTRequestMethod.GET;
			Assert.assertEquals( expected, target.getWebAPIHTTPRequestMethod( ) );
		}

		// 
		[Test]
		public function getMessageOnHTTPPollingStrategyTest( ) : void
		{
			var target : JoinRoomSendMessage = new JoinRoomSendMessage( 0, 0 );

			// ProtocolType.WebAPIはメッセージ送信する。ただしGETなので中身は何もない
			{
				var message : Object = target.getMessageOnHTTPPollingStrategy( ProtocolType.WebAPI );
				Assert.assertNotNull( message );
				for( var key : String in message )
				{
					// 空なオブジェクトが来て欲しいので、一度も走らないべきである
					Assert.fail( "JoinRoomSendMessage.getMessageOnHTTPPollingStrategyがGET呼び出しなのに値を渡そうとしています" );
				}
			}

			// その他すべてのProtocolTypeではメッセージを送信しない。従ってnullが来るべき
			for( var protocol : Object in [ ProtocolType.Comet, ProtocolType.HTTPPolling, ProtocolType.RTMFP ] )
			{
				var shouldNull : Object = target.getMessageOnHTTPPollingStrategy( protocol as ProtocolType );
				Assert.assertNull( shouldNull );
			}
		}
	}
}
