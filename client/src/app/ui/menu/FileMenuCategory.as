package app.ui.menu 
{
	import app.Events;
	import flash.events.Event;
	
	// メインメニューのカテゴリ「ファイル」を管理するクラス
	public class FileMenuCategory implements IMenuCategory
	{		
		// Tinyモードか否か。TinyモードではないならばDefaultモードである
		private var mIsTinyMode : Boolean = false;
		
		// 各メニュー要素のオブジェクト。クラスにしない簡易方式
		// このオブジェクトの状態を更新したらgetChildrenを登録したdataProviderはrefreshすること
		private var mSave : Object = { label:"セーブ", event: new Event( Events.REQ_SAVE ) };
		private var mLoad : Object = { label:"ロード", event: new Event( Events.REQ_LOAD ) };
		private var mSaveAll : Object = { label:"全データセーブ", event: new Event( Events.REQ_SAVE_ALL ) };
		private var mLoadAll : Object = { label:"全データロード(旧：シナリオデータ読み込み)", event: new Event( Events.REQ_LOAD_ALL ) };
		private var mSaveChatLog : Object = { label:"チャットログ保存", event: new Event( Events.REQ_SAVE_CHAT_LOG ) };
		private var mStartSessionRecording : Object = { label:"録画開始", event: new Event( Events.REQ_START_SESSION_RECORDING ) };
		private var mStopSessionRecording : Object = { label:"録画終了", event: new Event( Events.REQ_STOP_SESSION_RECORDING ) };
		private var mLogout : Object = { label:"ログアウト", event: new Event( Events.REQ_LOGOUT ) };
			
		// --------------------------------- IMenuCategory実装
		public function setModeDefault( ) : void { mIsTinyMode = false; }
		public function setModeTiny( ) : void { mIsTinyMode = true; }
		
		public function getChildren() : Array
		{
			if ( mIsTinyMode )
			{
				return getTinyModeChildren( );
			} else
			{
				return getDefaultModeChildren( );
			}
		}
		
		private function getDefaultModeChildren( ) : Array
		{
			return [
				mSave,
				mLoad,
				{type:"separator"},
				mSaveAll,
				mLoadAll,
				{type:"separator"},
				mSaveChatLog,
				mStartSessionRecording,
				mStopSessionRecording,
				{type:"separator"},
				mLogout,
			];
		}
		
		private function getTinyModeChildren( ) : Array
		{
			return [
				mSaveChatLog,
				mStartSessionRecording,
				mStopSessionRecording,
				mLogout,
			];
		}
	}
}