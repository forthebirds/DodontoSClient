package network 
{
	import network.send.ISendMessage;

	import network.strategy.INetworkStrategy;
	import network.strategy.NullNetworkStrategy;
	
	// ネットワークの抽象化
	// 実質的にはDodontoSで利用できる
	// 各ProtocolとISendData/IReceiveDataをを結びつけるクラス。
	// つまり各ProtocolのMediatorに他ならない
	// IReceiveProtocolからIReceiveDataが来た時にはイベントの形で送出される
	// NetworkにISendDataを送った場合は、現在のコンフィギュレーションに合わせて
	// 適切な送出先のISendProtocolが(1つ以上)選択されネットワークに送り出される
	// モノステートクラスなので注意
	public class Network 
	{
		// 現在のストラテジ
		// NullStrategyにすることで考えることを無くす
		private static var mStrategy : INetworkStrategy = new NullNetworkStrategy( );

		// ネットワーク構成のストラテジを変更する
		// このメソッドを呼び出すと、以前に設定されていたストラテジは破棄され、
		// それにともなって一旦コネクションが切断され
		// その後、新たなストラテジ側のコネクションを確立します。
		// これらの切断・接続処理には時間がかかるかもしれないため
		// 呼び出し側はユーザにWaitを求める出したり
		// WorkerThreadによる実行を検討するなどの対処が必要です
		public static function changeNetworkStrategy( strategy : INetworkStrategy ) : void
		{
			mStrategy.closeNetwork( );
			mStrategy = strategy;
			mStrategy.connectNetwork( );
		}
		
		// ネットワークメッセージを送信する
		public static function sendMessage( message : ISendMessage ) : void
		{
			// メッセージ送信
			mStrategy.sendMessage( message );
		}
	}
}	// package network

