package app.ui.menu 
{
	import app.Events;
	import flash.events.Event;
	
	// メインメニューのカテゴリ「ヘルプ」を管理するクラス
	public class HelpMenuCategory implements IMenuCategory
	{
		private var mVersion : Object = {label:"バージョン", event: new Event( Events.REQ_SHOW_VERSION ) };
		private var mManual : Object = {label:"マニュアル", event: new Event( Events.REQ_SHOW_MANUAL ) };
		private var mTutorialReplay : Object = {label:"チュートリアル動画", event: new Event( Events.REQ_PLAY_TUTORIAL_REPLAY ) };
		private var mOfficialSite : Object = {label:"オフィシャルサイトへ", event: new Event( Events.REQ_JUMP_OFFICIAL_SITE ) };

		// --------------------------------- IMenuCategory実装
		
		// ヘルプカテゴリはモードによる違いはない(と言うか表示されない)
		// そのため中身は無実装だが、気になるなら実装しても構わない
		public function setModeDefault( ) : void { }
		public function setModeTiny( ) : void { }
		
		public function getChildren() : Array
		{
			return [
				mVersion,
				mManual,
				mTutorialReplay,
				mOfficialSite
			];
		}
	}
}	// package ui.menu

