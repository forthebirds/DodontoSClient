package app.ui.menu 
{
	// メインメニューのカテゴリ「画像」を管理するクラス
	public class ImageMenuCategory implements IMenuCategory
	{
		// Tinyモードか否か。TinyモードではないならばDefaultモードである
		private var mIsTinyMode : Boolean = false;
		
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
				{label:"ファイルアップローダー", callback: onClickImageFileUploader },
				{label:"WEBカメラ撮影", callback: onClickWebCameraCaptureUploader },
				{type:"separator"},
				{label:"タグ編集", callback: onClickEditImageTag },
				{label:"画像削除", callback: onClickDeleteImage }
			];
		}
		
		private function getTinyModeChildren( ) : Array
		{
			return [
				{label:"ファイルアップローダー", data:"imageFileUploader"},
				{label:"タグ編集", data:"openImageTagManager"},
				{label:"画像削除", data:"deleteImage" }
			]
		}
		
		// --------------------------------- コールバック実装	
		private function onClickImageFileUploader( item : Object ) : void
		{
		}
		
		private function onClickWebCameraCaptureUploader( item : Object ) : void
		{
		}
		
		private function onClickEditImageTag( item : Object ) : void
		{
		}
		
		private function onClickDeleteImage( item : Object ) : void
		{
		}
	}
}	// package ui.menu
