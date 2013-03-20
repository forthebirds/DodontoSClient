package network 
{
	// プロトコルを識別するための定数宣言
	public class ProtocolType
	{
		// HTTPPollingProtocol
		public static const HTTPPolling : ProtocolType = new ProtocolType( );
		
		// WebAPIProtocol
		public static const WebAPI : ProtocolType  = new ProtocolType( );
		
		// CometProtocol
		public static const Comet : ProtocolType = new ProtocolType( );
		
		// RTMFPProtocol
		public static const RTMFP : ProtocolType = new ProtocolType( );
	}

}