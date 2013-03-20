package network.protocol 
{
	import flash.net.URLRequest;
	// HTTP経由の通信でポーリングを行うことでメッセージの受信を行うプロトコルです
	// ポーリング操作による受信のみを担当するためメッセージ送信は別途のプロトコルを作成する必要があります
	// 受信に用いるメッセージ様式のストラテジを切り替えることによって
	// * JSON
	// * MsgPack
	// などに対応できます
	public class HTTPPollingProtocol  implements IReceiveProtocol
	{
		// TODO: 上の説明にウソのない内容で実装
		
		public function HTTPPollingProtocol() 
		{
		}
	}
}