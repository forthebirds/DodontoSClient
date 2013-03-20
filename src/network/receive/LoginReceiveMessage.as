package network.receive
{
	//! DodontoFServerからのgetLoginInfoのレスポンス値を表現するクラス	
	//! http://admin.cokage.ne.jp/redmine/projects/dodontof/wiki/%E3%81%A9%E3%81%A9%E3%82%93%E3%81%A8%E3%81%B5%E3%83%97%E3%83%AD%E3%83%88%E3%82%B3%E3%83%AB%E8%A7%A3%E6%9E%90
	//! このような情報がGetLoginInfoでは飛んでくる様子
	//! これらのそれぞれがどのような意味を持つのかは不明瞭なので考えること
	//! あとloginMessageをGetLoginInfoに乗せるべきではないのではないか？
	//! サーバサイドからの通達を送るWebAPIは別枠のAPIを準備して分散するべきではないか？
	public class LoginReceiveMessage implements IReceiveMessage
	{
		public function LoginReceiveMessage( ) 
		{
			// TODO: apiurl = WebAPIアドレスの決定方法を考える
		}
		
		// ユーザがログインした時刻をもとに作られたユニークID
		// 時刻なので同一になる可能性があるのだが
		// そのようなことは起きないという前提で
		// ユーザアクセスの一意の識別子として用いている
		// ３６文字の文字列
		public function getUniqueID() : String
		{
			// todo: impl
			return null; // return mResponse[ "uniqueId" ];
		}
		
		public function getVersion() : String
		{
			// todo: impl
			return null; // return mResponse[ "version" ];
		}
	}
	
}	// package webapi