package network.protocol 
{
	import flash.events.SoftKeyboardTrigger;
	import flash.net.URLLoaderDataFormat;
	import network.impls.RESTLoader;
	import network.impls.RESTRequest;
	import network.impls.RESTRequestMethod;
	import network.send.ISendMessage;

	// HTTP経由の通信でWebAPIをクエリすることで
	// サーバへの送信とそのレスポンスの受信を行うプロトコルです。
	public class WebAPIProtocol 
		implements ISendProtocol, IReceiveProtocol
	{		
		public function WebAPIProtocol() 
		{
			mWorkers = new Vector.<RESTLoadWorker>( );
			for ( var i : uint = 0; i < cWorkerCount; ++i )
			{
				mWorkers.push( new RESTLoadWorker( this ) );
			}
			
			mRequestQueue = new Vector.<RESTRequest>( );
		}
				
		// WebAPI用のBaseURL(DodontoSサーバの設置ドメイン)を設定します
		// @param baseURL BaseURLの文字列表現
		public function setBaseURL( baseURL : String ) : void
		{
			mBaseURL = baseURL;
		}
		
		
		// ------------------------------ ISendProtocolから実装
		public function sendMessage(
			message : ISendMessage,
			data : * ,
			contentType : URLLoaderDataFormat
		) : void
		{
			// リクエスト作成
			var request : RESTRequest = new RESTRequest( );
			
			requset.url = mBaseURL + message.getWebAPIRelativeRequestAddress( );
			request.method = message.getWebAPIRequestMethod( );
			
			request.contentType = contentType;
			request.data = data;

			// リクエストをキューに入れる。もしかしたら即座に、あるいはだいぶんたってから送信される。
			enqueueRequest( request );
		}
		
		
		
		// -------------------------------------------------- private
		
		// 同時最大リクエスト数。あんまり増やすとサーバに高い負荷がかかるので避ける。
		// 5ってのも適当なので調節してください。
		// ちなみにRFC HTTP/1.1の最大2つっていうのはpersistent connectionのことなのでこれは違うよ？
		private static var cWorkerCount : uint = 5;
		
		private var mBaseURL : String;	// ベースURL。未設定ではまともに動作しない。
		private var mWorkers : Vector.<RestLoadWorker>;	// ワーカー。cWorkerCount == mWorkers.Length
		private var mRequestQueue : Vector.<RESTRequest>; // リクエストを保存しておくキュー
		
		private function enqueueRequest( request : RESTRequest ) : void
		{
			var worker ： RESTLoadWorker = searchUsableWorker( );
			if ( worker == null )
			{
				// 利用可能なものが無いのでキューに入れてそのうち送信されるさ、とあきらめるのさ。
				mRequestQueue.push( request );
				return;
			}
			// 利用可能なワーカーがあったので、それを使って送信
			worker.load( request );
		}
		
		// ワーカーで受信が完了したときに呼び出される
		internal function onComplete( worker : RESETLoadWorker ) : void
		{
			// todo: 受信イベント発行
			
			// メッセージ内容の受信が完了したのでリサイクルする
			worker.recycle( );
			// 次があれば送信
			sendNextMaybe( );
		}
		
		// ワーカーでエラーが発生した時に呼び出される
		internal function onError( worker : RESETLoadWorker ) : void
		{
			// todo: エラーイベント発行
			
			// メッセージ内容の受信が完了したのでリサイクルする
			worker.recycle( );
			// 次があれば送信
			sendNextMaybe( );
		}
		
		// 次のメッセージがあれば送信し、そうでなければ待機状態に入ります
		private function sendNextMaybe( worker　: RESTLoadWorker ) : void
		{
			if ( mRequestQueue.length > 0 )
			{
				// リクエストが残っているので即座に再送信
				RESTRequest request = mRequestQueue[ 0 ];
				// 送信対象は多重送信にならないように削除
				mRequestQueue.shift( );
				// ロードする
				worker.load( request );
			}
		}
		
		// 利用可能なワーカーがあれば獲得する。ないならnullを返す
		private function searchUsableWorker( ) : RESETLoadWorker
		{
			for ( var i : uint = 0; i < cWorkerCount; ++i )
			{
				// 利用可能なものがあればこれを使う
				// Mutexがなく、なんとなく恐いけど
				// Flashは常にシングルスレッド動作しているのでこれで問題ないはず。
				if ( !mWorkers[ i ].isUsable( ) ) return mWorkder[ i ];
			}
		}
		
		
	}
}

import network.impls.RESTLoader;
import flash.events.Event;
import flash.events.IOErrorEvent;

// RESTLoaderとその利用情報をセットにして管理する通信ワーカー
private class RESTLoadWorker
{
	public RESTLoadWorker( owner : WebAPIProtocol )
	{
		initialize( );
	}
	
	private var mLoader : RESTLoader;
	private var mIsLoading : Boolean;
	private var mOwner : WebAPIProtocol;
	
	public function isUsable( ) : Boolean { return (mLoader != null) && !mIsLoading; }
	
	private initialize( ) : void
	{
		mLoader = new RESTLoader( );
		mLoader.addEventListener( Event.COMPLETE, onComplete );
		mLoader.addEventListener( IOErrorEvent.IO_ERROR, onError );
		// このイベントもあるけれどドキュメントされてない。
		// あと、二つ同時に受信すると困る。
		// 仮にこれを入れる場合はfinalizeの対応するコメントアウトも入れる
		// mLoader.addEventListener( IOErrorEvent.NETWORK_ERROR, onError );
		
		mIsLoading = false;
		mOwner = owner;
	}
	
	// ワーカーを再利用するために前回の状態を破棄し、再生成を行います
	public recycle( ) : void
	{
		finalize( );
		initialize( );
	}
	
	// ワーカーを破棄します。
	public finalize( ) : var
	{
		mLoader.addEventListener( Event.COMPLETE, onComplete );
		mLoader.addEventListener( IOErrorEvent.IO_ERROR, onError );
		// コメントアウトの理由はinitializeの対応するコメントを参照
		// mLoader.removeEventListener( IOErrorEvent.NETWORK_ERROR, onError );
		
		mIsLoading = false;
	}
	
	// リクエストをRESTLoaderを使ってロードします
	public load( request : RESTRequset ) : void
	{
		// ASSERT( !mIsLoading );
		
		mIsLoading = true;
		mLoader.load( request );
	}
	
	private onComplete( ) : void { mOwner.onComplete( this ); }
	private onError( ) : void { mOwner.onError( ); }
}