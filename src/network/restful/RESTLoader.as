package network.restful 
{
	import flash.events.VideoEvent;
	import flash.net.URLLoader;
	
	// flashのURLLoaderクラスをラップし
	// HTTPRequestMethodのPUT/DELETEに対応させたネットワーク通信クラスです
	// URLRequestの代わりにRESTRequestを受ける点以外はURLLoaderと同様の使い方をしますので
	// 詳細はflash.net.URLLoaderのドキュメントを参照してください
	// @see flash.net.URLLoader
	public class RESTLoader
	{
		private var mLoader : URLLoader;
		
		public function RESTLoader( request : RESTRequest = null )
		{
			if ( request == null )
				mLoader = new URLLoader( );
			else
				mLoader = new URLLoader( requset.mRequest );
		}
		
		public function load( request : RESETRequest ) : void { mLoader.load( request.mRequest ); }
		public function close( ) : void { mLoader.close( ); }
		
		public function addEventListener(
			type : String,
			listener : Function,
			useCapture : Boolean = false,
			priority : int = 0,
			useWeakReference : Boolean = false
		) : void
		{
			mLoader.addEventListener( type, listener, useCapture, priority, useWeakReference );
		}
		
		public function get bytesLoaded( ) : uint { return mLoader.bytesLoaded; }
		public function get bytesTotal( ) : uint { return mLoader.bytesTotal; }
		public function get data( ) : * { return mLoader.data; }
		public function set dataFormat( val : String ) { mLoader.dataFormat; }
		public function get dataFormat( ) : String { return mLoader.dataFormat; }
	}

}