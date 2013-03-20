package app.model 
{
	public class PlayRoom 
	{	
		public function PlayRoom() 
		{
		}
				
		// 部屋情報を返します
		// @param roomIndex 部屋番号。0-origです。
		// @return 部屋情報。必ずしもロード済みとは限りません。ロードを走らせるためにはloadPlayRoomを走らせてください
		public static function getPlayRoom( roomIndex : int ) : PlayRoom
		{
		}
		
		// このルームロードは非同期に走るため、即座にアクセスしても結果が得られるとは限りません。
		//　リクエストされた部屋情報のロードが完了したときにはloadRoomCompleteメソッドが呼び出されます。
		public static function loadPlayRoom( startIndex : int, endRoomIndex : int ) : void
		{
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
	}

}