package app.ui.menu 
{
	// メインメニューのカテゴリ「マップ」を管理するクラス
	public class MapMenuCategory implements IMenuCategory
	{
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
				{label:"マップ変更", callback: onClickChangeMap },
				{label:"フロアタイル変更モード", callback: onClickChangeFloorTile },
				{label:"マップマスク追加", callback: onClickAddMapMask },
				{label:"簡易マップ作成", callback: onClickEasilyCreateMap },
				{type:"separator"},
				{label:"マップ状態保存", callback: onClickSaveMapState },
				{label:"マップ切り替え", callback: onClickLoadMapState },
			];
		}
		
		// --------------------------------- コールバック実装	
		private function onClickChangeMap( item : Object ) : void
		{
		}
		
		private function onClickChangeFloorTile( item : Object ) : void
		{
		}
		
		private function onClickAddMapMask( item : Object ) : void
		{
		}
		
		private function onClickEasilyCreateMap( item : Object ) : void
		{
		}
		
		private function onClickSaveMapState( item : Object ) : void
		{
		}
		
		private function onClickLoadMapState( item : Object ) : void
		{
		}
	}
}	// package ui.menu
