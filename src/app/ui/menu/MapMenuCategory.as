package app.ui.menu 
{
	import flash.events.Event;
	import app.Events;
	
	// メインメニューのカテゴリ「マップ」を管理するクラス
	public class MapMenuCategory implements IMenuCategory
	{
		private var mChangeMap : Object = {label:"マップ変更", event: new Event( Events.REQ_CHANGE_MAP) };
		private var mChangeFloorTile : Object = {label:"フロアタイル変更モード", event: new Event( Events.REQ_CHANGE_FLOOR_TILE ) };
		private var mAddMapMask : Object = {label:"マップマスク追加", event: new Event( Events.REQ_ADD_MAP_MASK ) };
		private var mEasilyCreateMap : Object = {label:"簡易マップ作成", event: new Event( Events.REQ_EASILY_CREATE_MAP ) };
		private var mSaveMapState : Object = {label:"マップ状態保存", event: new Event( Events.REQ_SAVE_MAP_STATE ) };
		private var mLoadMapState : Object = {label:"マップ切り替え", event: new Event( Events.REQ_LOAD_MAP_STATE ) };

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
				mChangeMap,
				mChangeFloorTile,
				mAddMapMask,
				mEasilyCreateMap,
				{type:"separator"},
				mSaveMapState,
				mLoadMapState,
			];
		}
	}
}	// package ui.menu
