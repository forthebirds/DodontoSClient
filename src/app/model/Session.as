package app.model 
{	
	import network.send.LoginSendMessage;

	// セッション・ログイン情報の管理を行うクラス
	public class Session
	{
		public function Session( )
		{	
		}

		public function setupNetwork( )
		{
			GlobalEventSelector.addEventListener( Events.RECEIVED_LOGIN, onReceivedLogin );
			GlobalEventSelector.addEventListener( Events.RECEIVED_LOGOUT, onReceivedLogout );
		}

		public function shutdownNetwork( )
		{
			GlobalEventSelector.removeEventListener( Events.RECEIVED_LOGIN, onReceivedLogin );
			GlobalEventSelector.removeEventListener( Events.RECEIVED_LOGOUT, onReceivedLogout );
		}
		
		public function login( ) : void
		{	
			var mes : LoginSendMessage = new LoginSendMessage( );
			// TODO: 具体的なパラメタ設定する
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
		public function getRoomInfo( roomIndex : int ) : RoomInfo
		{
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
