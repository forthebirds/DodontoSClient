package app
{
	import flash.net.SharedObject;
	
	import ui.components.IWindowSaveLoad;
	
	//! セーブデータの保存・読み込みを行うクラスです
	public class WindowSaveData implements IWindowSaveLoad
	{
		// 
		private const kTinyModeSaveKey : String = "TinyWindowSaveData";
		
		// 
		private const kNormalModeSaveKey : String = "WindowSaveData";
		
		// 
		private var mSaveData : SharedObject;
		
		public function WindowSaveData( isTinyMode : Boolean )
		{
			if ( isTinyMode )
			{
				mSaveData = SharedObject.getLocal( kTinyModeSaveKey );
			}else
			{
				mSaveData = SharedObject.getLocal( kNormalModeSaveKey );
			}
		}
		
		// -------------------------- IWindowSaveDataを実装
		public function loadWindowState( key : String ) : Object
		{
			return mSaveData[ key ];
		}
		
		public function saveWindowState( key : String , saveData : Object ) : void
		{
			mSaveData[ key ] = saveData;
		}
	}
}