package network.strategy 
{
	import network.NetworkStrategyType;
	import network.send.ISendMessage;
	
	public class NullNetworkStrategy implements INetworkStrategy 
	{
		public function getType( ) : NetworkStrategyType { return NetworkStrategyType.Null; }
		public function connectNetwork( ) : void { }
		public function closeNetwork( ) : void { }
		public function sendMessage( data : ISendMessage ) : void { }
	}

}	// package network

