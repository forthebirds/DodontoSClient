package app.ui.menu 
{
	import flash.events.Event;
	import app.Events;
	
	// メインメニューのカテゴリ「コマ」を管理するクラス
	public class PieceMenuCategory implements IMenuCategory
	{
		private var mAddCharacter : Object =
			{label:"キャラクター追加", event: new Event( Events.REQ_ADD_CHARACTER ) };
		private var mAddMagicRange : Object =
			{label:"魔法範囲追加(D&D3版)", event: new Event( Events.REQ_ADD_MAGIC_RANGE ) };
		private var mAddMagicRangeDD4th : Object =
			{label:"魔法範囲追加(D&D4版)", event: new Event( Events.REQ_ADD_MAGIC_RANGE_DD4TH ) };
		private var mAddMagicTimer : Object =
			{label:"魔法タイマー追加", event: new Event( Events.REQ_ADD_MAGIC_TIMER ) };
		private var mCreateChit : Object =
			{label:"チット作成", event: new Event( Events.REQ_CREATE_CHIT ) };
		private var mShowGraveyard : Object =
			{label:"墓場", event: new Event( Events.REQ_SHOW_GRAVEYARD ) };
		private var mShowCharacterWaitingRoom : Object =
			{label:"キャラクター待合室", event: new Event( Events.REQ_SHOW_CHARACTER_WAITING_ROOM ) };
		private var mSetRotateMarkerVisibility : Object =
			{label:"回転マーカーを表示する", type:"check", toggled:true, event: new Event( Events.REQ_SHOW_CHARACTER_WAITING_ROOM ) };

		// --------------------------------- IMenuCategory実装
		public function setModeDefault( ) : void
		{
		}
		
		public function setModeTiny( ) : void
		{
		}
		
		public function getChildren() : Array
		{
			return [
					mAddCharacter,
					mAddMagicRange,
					mAddMagicRangeDD4th,
					mAddMagicTimer,
					{type:"separator"},
					mCreateChit,
					{type:"separator"},
					mShowGraveyard,
					mShowCharacterWaitingRoom,
					{type:"separator"},
					mSetRotateMarkerVisibility,
				];
		}
	}
}	// package app.ui.menu

