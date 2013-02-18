package app 
{
	import flash.events.Event;
	
	// このファイル名は何とかならないかなあ。
	// アプリケーション全体で一貫して用いるイベント定数類がここに定義されているという話なんだけど……。
	
	// DodontoF全体で用いるイベント定数の列挙。
	// このイベント定数定義はアプリケーションとして意味のあるものを使う
	public class Events
	{		
		// セーブするようにリクエストされている
		public static const REQ_SAVE : String = "req_save";
		// セーブされた
		public static const ON_SAVED : String = "save";
		
		// ロードするようにリクエストされている
		public static const REQ_LOAD : String = "req_load";
		// ロードされた
		public static const ON_LOADED : String = "load";
		
		// 全データセーブするようにリクエストされている
		public static const REQ_SAVE_ALL : String = "req_save_all";
		// 全データセーブを行った
		public static const ON_SAVE_ALL : String = "save_all";
		
		// 全データロードするようにリクエストされている
		public static const REQ_LOAD_ALL : String = "req_load_all";
		// 全データロードを行った
		public static const ON_LOAD_ALL : String = "load_all";
		
		// チャットログをセーブするようにリクエストされている
		public static const REQ_SAVE_CHAT_LOG : String = "req_save_chat_log";
		// チャットログをセーブした
		public static const ON_SAVE_CHAT_LOG : String = "save_chat_log";
		
		// セッションの録画を開始するようにリクエストされている
		public static const REQ_START_SESSION_RECORDING : String = "req_start_session_recording";
		// セッションの録画を開始した
		public static const ON_START_SESSION_RECORDING : String = "start_session_recording";
		
		// セッションの録画を停止するようにリクエストされている
		public static const REQ_STOP_SESSION_RECORDING : String = "req_stop_session_recording";
		// セッションの録画を停止した
		public static const ON_STOP_SESSION_RECORDING : String = "stop_session_recording";
		
		// ログアウト操作を行うようにリクエストされている
		public static const REQ_LOGOUT : String = "req_logout";
		// ログアウト操作を行った
		public static const ON_LOGOUT : String = "logout";
		
		// TODO: このイベントは「表示」と「非表示」を分離する
		// カードピックアップウィンドウの表示・非表示を設定するようにリクエストされている
		public static const REQ_SET_CARDS_PICKUP_VISIBILITY : String = "req_set_cards_pickup_visibility";
		// カードピックアップウィンドウの表示・非表示を変更した
		public static const ON_SET_CARDS_PICKUP_VISIBILITY : String = "on_set_cards_pickup_visibility";
		
		// カード配置の初期化を行うようにリクエストされている
		public static const REQ_INIT_CARDS_POSTURE : String = "req_init_cards_posture";
		// カード配置の初期化を行った
		public static const ON_INIT_CARDS_POSTURE : String = "init_cards_posture";
		
		// カードの全削除を行うようにリクエストされている
		public static const REQ_CLEAN_CARDS : String = "req_clean_cards";
		// カードの全削除を行った
		public static const ON_CLEAN_CARDS : String = "on_clean_cards";
	}
}