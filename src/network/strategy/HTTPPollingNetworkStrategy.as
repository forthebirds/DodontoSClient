package network.strategy 
{
	import flash.net.URLLoaderDataFormat;
	import network.NetworkStrategyType;
	import network.send.ISendMessage;

	import network.protocol.HTTPPollingProtocol;
	import network.protocol.WebAPIProtocol;
	
	import network.ProtocolType;
		
	public class HTTPPollingNetworkStrategy implements INetworkStrategy
	{
		private var mPoller : HTTPPollingProtocol = null;
		private var mQuerier : WebAPIProtocol = null;

		private var mIsConnected : Boolean = false;
		
		// WebAPI用のBaseURL(DodontoSサーバの設置ドメイン)を設定します
		// @param baseURL BaseURLの文字列表現
		public function setBaseURL( baseURL : String ) : void
		{
			mQuerier.setBaseURL( baseURL );
		}
		
		// ------------------------------ INetworkStrategyから実装
		
		public function getType( ) : NetworkStrategyType
		{
			return NetworkStrategyType.HTTPPolling;
		}

		public function connectNetwork( ) : void
		{
			mPoller = new HTTPPollingProtocol( );
			mQuerier = new WebAPIProtocol( );

			// ポーリングのセットアップ != サーバへのポーリング開始
			// 実際にポーリングが開始されるのはmPollerが
			// mQuerierのログインメッセージの結果発行された
			// イベントをキャプチャした時になる。
			mPoller.setupPolling( );
		}

		public function closeNetwork( ) : void 
		{
			mPoller.shutdownPolling( );
		}

		public function sendMessage( message : ISendMessage ) : void
		{
			var data : Object = message.getMessageOnHTTPPollingStrategy( ProtocolType.WebAPI );
			
			// TODO: JSONやMsgPackに変換
			// var json : JSON = ... ;
			// TODO: 第三引数はJSONならTEXTだしMSGPACKならBINARYだし……。
			// mQuerier.sendMessage( message , json, URLLoaderDataFormat.TEXT );
		}
	}

}	// package network

