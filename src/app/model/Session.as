package app.model 
{	
	import app.GlobalEventSelector;
	import app.Events;
	
	import network.send.JoinRoomSendMessage;
	import network.Network;

	// セッション・ログイン情報の管理を行うクラス
	public class Session
	{
		public function Session( )
		{	
		}

		public function setupNetwork( ) : void
		{
			GlobalEventSelector.addEventListener( Events.RECEIVED_LOGIN, onReceivedLogin );
			GlobalEventSelector.addEventListener( Events.RECEIVED_LOGOUT, onReceivedLogout );
		}

		public function shutdownNetwork( ) : void
		{
			GlobalEventSelector.removeEventListener( Events.RECEIVED_LOGIN, onReceivedLogin );
			GlobalEventSelector.removeEventListener( Events.RECEIVED_LOGOUT, onReceivedLogout );
		}
		
		public function login( ) : void
		{	
			// TODO: 具体的なパラメタを設定する
			var mes : JoinRoomSendMessage = new JoinRoomSendMessage( 0, 0 );
			Network.sendMessage( mes );

			// レスポンス待ちになるが。。。
			// LoginReceiveMessageは
			// 自分がSession(Model)に対して何をするべきか知っている？
		}
		
		public function logout( ) : void
		{
			// var mes : LogoutSendMessage = new LogoutSendMessage( );
			// Network.sendMessage( mes );
		}

		// ログイン中の部屋情報獲得
		public function getRoomInfo( roomIndex : int ) : PlayRoom
		{
			// TODO: impl
			return null;
		}

		// ログインメッセージを受信した時に呼び出されるメソッド
		private function onReceivedLogin( ) : void
		{
		}

		// ログアウトメッセージを受信したときに呼び出されるメソッド
		private function onReceivedLogout( ) : void
		{
		}
	}
}
