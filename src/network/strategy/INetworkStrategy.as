package network.strategy 
{
	import network.NetworkStrategyType;
	
	import network.send.ISendMessage;
	
	import network.protocol.ISendProtocol;
	import network.protocol.IReceiveProtocol;

	// ネットワーク接続の構成戦略の抽象化
	// どういうプロトコルでどういうところにどういうメッセージを送るのか
	// というのをストラテジとして区別する
	//
	// INetworkStrategyには、コネクションという概念が登場する
	// コネクションは、
	// ・送受信操作が可能になる準備を整えており、
	// ・ネットワーク状態などのコンディションが正常ならば
	// ・通信内容が到着する
	// ことを示す。
	// つまり、コネクションが張ってあっても
	// ネットワーク状態が異常であれば
	// 通信が来なく／到着しなくなることは考えられる
	// したがって通信を送っても、
	// それが到着する、ということを前提にコーディングするべきでない。
	// このような前提のため、connectNetworkは「必ず成功する」
	// しかし、成功しているからユーザコードとしてはなんだ、という話ではある
	// むしろこのメソッドは内側の準備期間として必要。
	public interface INetworkStrategy
	{
		// このストラテジの種類を示す定数を取得する
		function getType( ) : NetworkStrategyType;

		// コネクションを確立する
		// ユーザコードはこのメソッドの実行には
		// 時間がかかるかもしれないことを念頭に置く必要がある。
		function connectNetwork( ) : void;

		// このストラテジの通信切断を行い、終了可能状態になる
		// ユーザコードはこのメソッドの実行には
		// 時間がかかるかもしれないことを念頭に置く必要がある。
		function closeNetwork( ) : void;

		// このストラテジで用いる各種プロトコルでの送信を行なう
		function sendMessage( data : ISendMessage ) : void;

		// 受信メソッドはない、各プロトコルが直接GlobalEventDispatcherに配信する
	}

}	// package network

