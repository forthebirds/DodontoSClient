package app.model 
{
	import flash.sampler.NewObjectSample;
	import network.Network;
	import network.send.RoomStatusSendMessage;
	public class PlayRoom 
	{	
		public function PlayRoom() 
		{
		}
		
		// グローバルな初期化メソッド
		// このメソッドで設定がなされる前にそのほかのPlayRoomのメソッドを利用してはなりません。
		// @param roomCount 取り扱う最大の部屋数を設定します。一般に何らかの経路でサーバから通知された部屋数を用います。
		public static function initialize( roomCount : uint ) : void
		{
			mPlayRoom.length = count;
			for ( i : uint = 0; i < count; ++i )
			{
				mPlayRoom[ i ] = new PlayRoom( );
			}
		}
				
		// 部屋情報を返します
		// @param roomIndex 部屋番号。0-origです。
		// @return 部屋情報。必ずしもロード済みとは限りません。ロードを走らせるためにはloadPlayRoomを走らせてください
		public static function getPlayRoom( roomIndex : int ) : PlayRoom
		{
			if ( roomIndex >= mPlayRoom.length ) return null;
			return mPlayRoom[ roomIndex ];
		}
		
		// 指定された範囲の部屋の現在の状態をロードします。
		// このルームロードは非同期に走るため、即座にアクセスしても結果が得られるとは限りません。
		//　リクエストされた部屋情報のロードが完了したときに、引数に渡されたloadRoomCompleteメソッドが呼び出されます。
		public static function loadPlayRoom(
			startIndex : int, endRoomIndex : int,
			loadRoomComplete : Function
		) : void
		{
			Network.sendMessage( new RoomStatusSendMessage( startIndex, endRoomIndex, loadRoomComplete ) );
		}
		
		// この部屋情報がすでにサーバと同期済みか否かを返します
		public function isLoaded( ) : Boolean
		{
			// TODO: impl
			return false;
		}
		
		// この部屋に何人のユーザがログインしているかを返します
		public function getMemberCount( ) : int
		{
			// TODO: impl
			return 0;
		}
		
		// グローバルに共有される、読み込み済みのプレイルーム情報
		private static var mPlayRoom : Vector.<PlayRoom> = new Vector.<PlayRoom>( );
	}

}