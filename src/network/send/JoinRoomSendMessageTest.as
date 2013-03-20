package network.send
{
	import org.flexunit.Assert;
	
	public class JoinRoomSendMessageTest
	{
		// 生成可能かのテスト。一度でも参照しなければビルドエラーすら出ないFlexの仕様対策。ほかのテストができれば削除のこと
		[Test] public function constructive( ) : void
		{
			new JoinRoomSendMessage( 0, 0 );
		}
	}
}