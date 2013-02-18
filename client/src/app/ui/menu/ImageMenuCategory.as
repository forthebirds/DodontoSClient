package app.ui.menu 
{
	import flash.events.Event;
	import app.Events;

	// メインメニューのカテゴリ「画像」を管理するクラス
	public class ImageMenuCategory implements IMenuCategory
	{
		// Tinyモードか否か。TinyモードではないならばDefaultモードである
		private var mIsTinyMode : Boolean = false;

		private var mImageFileUploader : Object =
			{label:"ファイルアップローダー", event: new Event( Events.REQ_OPEN_IMAGE_FILE_UPLOADER ) };
		private var mWebCameraCaptureUploader : Object =
			{label:"WEBカメラ撮影", event: new Event( Events.REQ_OPEN_WEB_CAMERA_CAPTURE_UPLOADER ) };
		private var mEditImageTag : Object =
			{label:"タグ編集", event: new Event( Events.REQ_EDIT_IMAGE_TAG ) };
		private var mDeleteImage : Object =
			{label:"画像削除", event: new Event( Events.REQ_DELETE_IMAGE ) };
		
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
				mImageFileUploader,
				mWebCameraCaptureUploader,
				{type:"separator"},
				mEditImageTag,
				mDeleteImage
			];
		}
		
		private function getTinyModeChildren( ) : Array
		{
			return [
				mImageFileUploader,
				mEditImageTag,
				mDeleteImage
			]
		}
	}
}	// package ui.menu
