package network.protocol 
{
	// RTMFP経由の通信を行うプロトコルです
	// RTMProtocolProtocolになってるけど前者と後者は意味付けが違うものです。
	// (一般性のある通常の言葉としてのProtocolと、
	// DodontoS内部の抽象としてのIProtocol実装者という意味のProtocolは
	// あくまで同音異義語みたいなものであって違うものと考える)
	public class RTMFPProtocol 
		implements ISendProtocol, IReceiveProtocol
	{
		
		public function RTMFPProtocol() 
		{
			
		}
		
	}

}