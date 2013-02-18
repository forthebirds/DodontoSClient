package app.ui.menu 
{
	// メインメニューのカテゴリ「表示」を管理するクラス
	public class DisplayMenuCategory implements IMenuCategory
	{
		// Tinyモードか否か。TinyモードではないならばDefaultモードである
		private var mIsTinyMode : Boolean = false;	
		
		public function DisplayMenuCategory() 
		{
				
		}
		
		// --------------------------------- IMenuCategory実装
		public function setModeDefault( ) : void
		{
			mIsTinyMode = false;
		}
		
		public function setModeTiny( ) : void
		{
			mIsTinyMode = true;
		}
		
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
				{label:"チャットパレット表示", type:"check", toggled:false, callback: onSetChatPaletteVisibility},
				{label:"カウンターリモコン表示", type:"check", toggled:false, callback: onSetCounterRemoteControllerVisibility},
				{type:"separator"},

				{label:"チャット表示", type:"check", toggled:true, callback: onSetChatVisibility},
				{label:"ダイス表示", type:"check", toggled:true, callback: onSetDiceVisibility},
				{label:"イニシアティブ表示", type:"check", toggled:true, callback: onSetInitiativeListVisibility},
				{type:"separator"},

				{label:"立ち絵表示", type:"check", toggled:true, callback: onSetStandingGraphicVisibility},
				{label:"カットイン表示", type:"check", toggled:true, callback: onSetCutInVisibility },
				{type:"separator"},

				{label:"座標表示", type:"check", toggled:true, callback: onSetPositionVisibility },
				{label:"マス目表示", type:"check", toggled:true, callback: onSetGridVisibility },
				{type:"separator"},

				{label:"マス目にキャラクターを合わせる", type:"check", toggled:true, callback: onSetPieceSnap},
				{label:"立ち絵のサイズを自動調整する", type:"check", toggled: true, callback: onSetAutoAdjustImageSize },
				{type:"separator"},

				{label:"ウィンドウ配置初期化", callback: onInitWindowState },
				{label:"表示状態初期化", callback: onInitLocalSaveData }
			];
		}
		
		
		private function getTinyModeChildren( ) : Array
		{
			return [
				{ label:"立ち絵のサイズを自動調整する", type:"check", toggled: true, callback: onSetAutoAdjustImageSize },
				{ type:"separator" },
				{ label:"背景変更", data:"changeMap" },
			];
		}
		
		// --------------------------------- メニューのハンドラ
		private function onSetChatPaletteVisibility( item : Object ) : void
		{
		}
		
		private function onSetCounterRemoteControllerVisibility( item : Object ) : void
		{
		}
		
		private function onSetChatVisibility( item : Object ) : void
		{
		}
		
		private function onSetDiceVisibility( item : Object ) : void
		{
		}
		
		private function onSetInitiativeListVisibility( item : Object ) : void
		{
		}
		
		private function onSetStandingGraphicVisibility( item : Object ) : void
		{
		}
		
		private function onSetCutInVisibility( item : Object ) : void
		{
		}
		
		private function onSetPositionVisibility( item : Object ) : void
		{
		}
		
		private function onSetGridVisibility( item : Object ) : void
		{
		}
		
		private function onSetPieceSnap( item : Object ) : void
		{
		}
		
		private function onSetAutoAdjustImageSize ( item : Object ) : void
		{
		}
		
		private function onInitWindowState( item : Object ) : void
		{	
		}
		
		private function onInitLocalSaveData( item : Object ) : void
		{
		}
	}
}