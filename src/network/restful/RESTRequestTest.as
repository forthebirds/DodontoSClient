package network.restful
{
	import org.flexunit.Assert;

	import flash.net.URLRequestMethod;
	
	public class RESTRequestTest
	{
		// 初期値が決めたとおりかどうかのテスト
		[Test] public function initialStateTest( ) : void
		{
			// デフォルト値でのテスト
			{
				// スコープを作って分離しているのに、変数名が被ると警告が出る
				// LexicalScopeではないのかなあ？
				var targetA : RESTRequest = new RESTRequest( );

				Assert.assertNull( targetA.data );
				// URLRequestのドキュメントに
				// デフォルトが"application/x-www-form-urlencoded"と記載されているにも関わらず
				// 実際にはnullが返ってくるようで、仕方ないのでRESTRequestもこの実装に従うことにした
				// そのためこのテストではNullが必ず帰ってくるかをチェックしている
				// Assert.assertEquals( "application/x-www-form-urlencoded", targetA.contentType );
				Assert.assertNull( targetA.contentType );
				Assert.assertEquals( RESTRequestMethod.GET, targetA.method );

				// urlについてはコンストラクタでnullの時のURLRequestのドキュメントにデフォルト値の記載が無い。
				// emptyStringになるかnullになるか。。。後者だとは思うのだけど。
				// RESTRequestも同様の動作なら何も期待できないのでテストできない。
				// Assert.assertNull( target.url );	
			}

			// 適当なURLを入れた場合のテスト
			{
				var targetB : RESTRequest = new RESTRequest( "http://www.example.com/" );

				Assert.assertNull( targetB.data );
				// URLRequestのドキュメントに
				// デフォルトが"application/x-www-form-urlencoded"と記載されているにも関わらず
				// 実際にはnullが返ってくるようで、仕方ないのでRESTRequestもこの実装に従うことにした
				// そのためこのテストではNullが必ず帰ってくるかをチェックしている
				// Assert.assertEquals( "application/x-www-form-urlencoded", targetA.contentType );
				Assert.assertNull( targetB.contentType );
				Assert.assertEquals( RESTRequestMethod.GET, targetB.method );
				Assert.assertEquals( "http://www.example.com/", targetB.url );	
			}
		}

		// RESTRequestMethodの設定と獲得がエラーなども発生せず妥当な値で帰るのかのテスト
		[Test] public function methodTest( ) : void
		{
			var methods : Array = [
				RESTRequestMethod.GET,
				RESTRequestMethod.POST,
				RESTRequestMethod.PUT,
				RESTRequestMethod.DELETE
			];

			// 設定したメソッドを獲得できる
			for( var i : uint = 0; i < methods.length; ++i )
			{			
				var target : RESTRequest = new RESTRequest( );
				var protocol : RESTRequestMethod = methods[ i ];
				target.method = protocol;
				Assert.assertEquals( protocol, target.method );
			}
		}
		
		// 送信先URLの設定と獲得がエラーなども発生せず妥当な値で帰るのかのテスト
		[Test] public function urlTest( ) : void
		{
			var URLs : Array = [
				"http://www.example.com/",	// http
				"https://www.example.com/",	// https
				"",	// 空文字列
				null,	// null
			];

			// 設定したURLを獲得できる
			for( var i : uint = 0; i < URLs.length; ++i )
			{
				var target : RESTRequest = new RESTRequest( );
				var url : String = URLs[ i ];
				target.url = url;
				Assert.assertEquals( url, target.url );
			}
		}
		
		
		// データの設定と獲得がエラーなども発生せず妥当な値で帰るのかのテスト
		[Test] public function dataTest( ) : void
		{
			var obj : Object = new Object( );

			// 設定したデータを獲得できる
			var target : RESTRequest = new RESTRequest( );
			target.data = obj;
			Assert.assertEquals( obj, target.data );
		}
	}
}
