package network.receive
{
	import org.flexunit.Assert;
	
	public class LoginReceiveMessageTest
	{
		// 生成可能かのテスト。一度でも参照しなければビルドエラーすら出ないFlexの仕様対策。ほかのテストができれば削除のこと
		[Test] public function constructive( ) : void
		{
			new LoginReceiveMessage( );
		}
	}
}