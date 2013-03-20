package network.protocol 
{
	// HTTP経由の通信でポーリングを行うことでメッセージの受信を行うプロトコルです
	// コメットコネクションによる受信のみを担当するためメッセージ送信は別途のプロトコルを作成する必要があります
	// 受信に用いるメッセージ様式のストラテジを切り替えることによって
	// * JSON
	// * MsgPack
	// などに対応できます
	public class CometProtocol implements IReceiveProtocol
	{
		// TODO: 上記に嘘がないように実装(優先度低)
		
		public function CometProtocol() 
		{
			
		}
	}
}
