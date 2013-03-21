package 
{
	import org.flexunit.Assert;
	
	public class UtilsTest
	{
		// 生成可能かのテスト。一度でも参照しなければビルドエラーすら出ないFlexの仕様対策。ほかのテストができれば削除のこと
		[Test] public function constructive( ) : void
		{
			new Utils( );
		}

		// deleteItemFromArray削除が妥当に削除を実施出来るかテスト
		[Test]
		public function deleteItemFromArray( ) : void
		{
			var array : Array = [ 1, 2, 13, 7, 1, 5 ];
			const item : uint = 1;
			const expected : Array = [ 2, 13, 7, 5 ];

			Utils.deleteItemFromArray( array, item );

			// 処理後の長さは等しいはず
			Assert.assertEquals( expected.length, array.length );

			// すべてのアイテムが一致するはず
			for( var i : uint = 0; i < expected.length; ++i )
			{
				Assert.assertEquals( expected[ i ], array[ i ] );
			}
		}
	}
}
