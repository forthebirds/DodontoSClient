package network 
{
	public class NetworkStrategyType 
	{
		// Nullストラテジ
		public static const Null : NetworkStrategyType = new NetworkStrategyType( );
		
		// HTTPPollingを用いたネットワーク構成
		public static const HTTPPolling : NetworkStrategyType = new NetworkStrategyType( );
		
	}
}