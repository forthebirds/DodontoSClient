package network.protocol 
{
	import flash.net.URLLoaderDataFormat;
	import network.send.ISendMessage;
	
	
	// ネットワーク通信に用いる送信プロトコルのインタフェイス
	// DodontoSにおいて各プロトコルは以下の4つの機能を提供する
	// (エンコード・デコード)
	//    送受信が必要なデータを、DodontoS側の「Data」様式から、そのプロトコル上のエンコード様式に変換する
	// (送信)
	//    ネットワークに向かうデータ
	// (受信)
	//    ネットワーク側からのデータ受信
	//    ポーリングを用いたり、
	// これらの操作のうち、送信時のエンコード処理と
	// 実際の送信を実行可能なプロトコルがISendProtocolである
	public interface ISendProtocol
	{
		// メッセージ送信を行う。
		// data, contentTypeはどちらもmessageにあるように思われるかもしれないが
		// 実際にはそれを妥当にISendMessageから引き出せるのはProtocolではなく
		// JSON, MsgPackなどのエンコード様式を把握しているNetworkStrategyであるため、
		// ISendProtocol実装者は指定された引数のほうを信用するべきである。
		function sendMessage(
			message : ISendMessage,
			data : * ,
			contentType : String
		) : void;
	}
}
