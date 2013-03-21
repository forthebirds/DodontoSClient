package network.restful 
{	
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLRequestHeader;
	
	public class RESTRequest 
	{
		internal var mRequest : URLRequest;
		private var mMethod : RESTRequestMethod;
		
		private static const cPUTHeader : URLRequestHeader =
			new URLRequestHeader("X-HTTP-Method-Override", "PUT");
			
		private static const cDELETEHeader : URLRequestHeader =
			new URLRequestHeader("X-HTTP-Method-Override", "DELETE");
		
		public function RESTRequest( url : String = null )
		{
			mRequest = new URLRequest( url );
			method = RESTRequestMethod.GET;	// defaultはGET
		}
		
		public function set data( val : Object ) : void { mRequest.data = val ; }
		public function get data( ) : Object { return mRequest.data; }
		
		// contentTypeのデフォルト値挙動はURLRequestのドキュメントとは一致しません！
		// URLRequestのドキュメントでは、
		// デフォルトが"application/x-www-form-urlencoded"と記載されているにも関わらず
		// 実際のURLRequestからはnullが返ってくるようで、仕方ないのでRESTRequestもこの実装に従うことにしました。
		public function set contentType( val : String ) : void { mRequest.contentType = val; }
		public function get contentType( ) : String { return mRequest.contentType; }
		
		public function set url( val : String ) : void { mRequest.url = val; }
		public function get url( ) : String { return mRequest.url; }
		
		// TODO: impl, あるいは無矛盾に保つのはとても難しいため,あえて提供しなくてもよいかもしれない。
		// public function get requestHeaders( ) : Array { return null; };
		
		public function set method( val : RESTRequestMethod ) : void
		{
			mMethod = val;
			
			// 整合性のために既設定なPUT,DELETE用のヘッダを削除しておく。
			Utils.deleteItemFromArray( mRequest.requestHeaders, cPUTHeader );
			Utils.deleteItemFromArray( mRequest.requestHeaders, cDELETEHeader );
			
			// RequestMethodごとにやること違うのでその辺。
			switch( method )
			{
			case RESTRequestMethod.GET:
				mRequest.method = URLRequestMethod.GET;
				break;
				
			case RESTRequestMethod.POST:
				mRequest.method = URLRequestMethod.POST;
				break;
				
			case RESTRequestMethod.PUT:
				mRequest.method = URLRequestMethod.POST;
				mRequest.requestHeaders.push( cPUTHeader );
				break;
				
			case RESTRequestMethod.DELETE:
				mRequest.method = URLRequestMethod.POST;
				mRequest.requestHeaders.push( cDELETEHeader );
				break;
				
			default:
				// TODO: Utils.Assert( cond );でも作ってAssertionExceptionとかってthrowしておくかなかーなー？
				// NEVER_THROUGH( );
				break;
			}
		}
		
		public function get method( ) : RESTRequestMethod { return mMethod; }
	}

}