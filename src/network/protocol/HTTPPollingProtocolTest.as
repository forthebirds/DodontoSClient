package network.protocol
{
	import org.flexunit.Assert;
	
	public class HTTPPollingProtocolTest
	{
		// 生成可能かのテスト。一度でも参照しなければビルドエラーすら出ないFlexの仕様対策。ほかのテストができれば削除のこと
		[Test] public function constructive( ) : void
		{
			new HTTPPollingProtocol( );
		}
	}
}