package app.ui
{
	import org.flexunit.Assert;
	
	public class LoginWindowTest
	{
		// 生成可能かのテスト。一度でも参照しなければビルドエラーすら出ないFlexの仕様対策。ほかのテストができれば削除のこと
		[Test] public function constructive( ) : void
		{
			new LoginWindow( );
		}
	}
}