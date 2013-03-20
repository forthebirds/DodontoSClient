package network.send 
{
	import network.restful.RESTRequestMethod;
	import network.ProtocolType;
	
	// ネットワーク上に送信するメッセージ
	// * どの送付先に送信されるべきなのか
	// * その送付先には、このデータのどの部分を送信するべきなのか
	// * ある送付先について、このメッセージに特別な設定データ
	// といった情報を、コンフィギュレーションごとに自律的に知っており
	// それらのコンフィギュレーションを問われれば答えることができる
	// ISendDataはメソッドのない純粋なObjectの形で送信データを保持しており
	// このObjectはProtocolごとにエンコードされて送信される
	public interface ISendMessage
	{
		// 各種コンフィグのメソッドを作っていくのは、コンフィグが増えたときに
		// そのコンフィグでの取得メソッドを未実装なSendDataをすぐ検出できるようにするため。
		
		// ポーリング時のサーバ通信 + WebAPIリクエストによる送受信設定時の送信データを取得する
		// もしそのプロトコルへ何も送信を行わない場合はnullを返す
		// @protocol 送信先プロトコル定数。指定のプロトコル分の送信データを返す
		function getMessageOnHTTPPollingStrategy( protocol : ProtocolType ) : Object;

		// TODO: Cometはとりあえず後回しにするが、そのうち実装
		// Comet通信 + WebAPIリクエストによる送受信設定時の送信データを取得する
		// もしそのプロトコルへ何も送信を行わない場合はnullを返す
		// @protocol 送信先プロトコル定数。指定のプロトコル分の送信データを返す
		// function getMessageOnCometPollingStrategy( protocol : ProtocolType ) : Object;
		
		// TODO: RTMFPはとりあえず後回しにするが、そのうち実装
		// P2P通信 + なんらかのClient/Server通信時の送信データを取得する。
		// もしそのプロトコルへ何も送信を行わない場合はnullを返す
		// @param protocol 送信先プロトコル定数。指定されたプロトコル分の送信データを返す。
		// function getMessageOnP2PStrategy( protocol : ProtocolType ) : Object;
		
		// WebAPIのリクエストRelativeURLを返す。RelativeURLは勝手に定めた言葉だが、
		// ドメインやDodontoSの設置位置から数えた相対的なリクエストURLのこと。
		// もしWebAPIを利用した送受信を行わない場合には、nullを返す。
		function getWebAPIRelativeRequestAddress( ) : String;
		
		// WebAPIリクエストのHTTPRequestMethodを返す。
		function getWebAPIHTTPRequestMethod( ) : RESTRequestMethod;
	}	
}
