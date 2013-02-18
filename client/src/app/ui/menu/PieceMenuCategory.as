package app.ui.menu 
{
	// メインメニューのカテゴリ「コマ」を管理するクラス
	public class PieceMenuCategory implements IMenuCategory
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
					{label:"キャラクター追加", callback: onAddCharacter },
					{label:"魔法範囲追加(D&D3版)", callback: onAddMagicRange },
					{label:"魔法範囲追加(D&D4版)", callback: onAddMagicRangeDD4th },
					{label:"魔法タイマー追加", callback: onAddMagicTimer },
					{type:"separator"},
					{label:"チット作成", callback: onCreateChit },
					{type:"separator"},
					{label:"墓場", callback: onShowGraveyard },
					{label:"キャラクター待合室", callback: onShowCharacterWaitingRoom },
					{type:"separator"},
					{label:"回転マーカーを表示する", callback: onSetRotateMarkerVisibility, type:"check", toggled:true},
				];
		}
		
		// --------------------------------- メニューのハンドラ
		private function onAddCharacter( item : Object ) : void
		{
		}
		
		private function onAddMagicRange( item : Object ) : void
		{
		}
		
		private function onAddMagicRangeDD4th( item : Object ) : void
		{
		}
		
		private function onAddMagicTimer( item : Object ) : void
		{
		}
		
		private function onCreateChit( item : Object ) : void
		{
		}
		
		private function onShowGraveyard( item : Object ) : void
		{
		}
		
		private function onShowCharacterWaitingRoom( item : Object ) : void
		{
		}
		
		private function onSetRotateMarkerVisibility( item : Object ) : void
		{
		}
	}
}