package app.model 
{
	import flash.sampler.NewObjectSample;
	import network.Network;
	import network.send.RoomStatusSendMessage;
	import network.receive.RoomStatusReceiveMessage;
	
	public class PlayRoom 
	{	
		public function PlayRoom() 
		{
			mIsLoaded = false;
		}
		
		// グローバルな初期化メソッド
		// このメソッドで設定がなされる前にそのほかのPlayRoomのメソッドを利用してはなりません。
		// @param roomCount 取り扱う最大の部屋数を設定します。一般に何らかの経路でサーバから通知された部屋数を用います。
		public static function initialize( roomCount : uint ) : void
		{
			sPlayRoom.length = roomCount;
			for ( var i : uint = 0; i < roomCount; ++i )
			{
				sPlayRoom[ i ] = new PlayRoom( );
			}
		}
		
		// グローバルな終了メソッド
		// このメソッドの呼び出しを行うと安全に終了できます
		public static function finalize( ) : void
		{
			sPlayRoom.length = 0;
		}
				
		// 部屋情報を返します
		// @param roomIndex 部屋番号。0-origです。
		// @return 部屋情報。必ずしもロード済みとは限りません。ロードを走らせるためにはloadPlayRoomを走らせてください
		public static function getPlayRoom( roomIndex : int ) : PlayRoom
		{
			if ( roomIndex >= sPlayRoom.length ) return null;
			return sPlayRoom[ roomIndex ];
		}
		
		// 指定された範囲の部屋の現在の状態をロードします。
		// このルームロードは非同期に走るため、即座にアクセスしても結果が得られるとは限りません。
		//　リクエストされた部屋情報のロードが完了したときに、引数に渡されたloadRoomCompleteメソッドが呼び出されます。
		public static function loadPlayRoom(
			startRoomIndex : int, endRoomIndex : int,
			loadRoomComplete : Function
		) : void
		{
			Network.sendMessage(
				new RoomStatusSendMessage(
					startRoomIndex, endRoomIndex,
					function( received : RoomStatusReceiveMessage ) : void
					{
						// 読み込んで設定する
						for ( var i : uint = startRoomIndex; (i < endRoomIndex) && (i < sPlayRoom.length); ++i )
						{
							sPlayRoom[ i ].mIsLoaded = true;
							sPlayRoom[ i ].mMemberCount = received.getMemberCount( );
						}
						
						// ロード完了したので予約されている関数を呼び出しておく
						if ( loadRoomComplete != null )
						{
							loadRoomComplete( );
						}
					}
				)
			);
		}
		
		// この部屋情報がすでにサーバと同期済みか否かを返します
		public function isLoaded( ) : Boolean
		{
			return mIsLoaded;
		}
		
		// この部屋に何人のユーザがログインしているかを返します
		public function getMemberCount( ) : int
		{
			return mMemberCount;
		}
		
		// グローバルに共有される、読み込み済みのプレイルーム情報
		private static var sPlayRoom : Vector.<PlayRoom> = new Vector.<PlayRoom>( );
		
		// ロード済みか否か
		private var mIsLoaded : Boolean;
		// メンバー数
		private var mMemberCount : uint;
	}

}