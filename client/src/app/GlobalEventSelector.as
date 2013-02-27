package app 
{
	import flash.events.IEventDispatcher;
	
	// 全体で利用するイベント送出先を管理します
	// 通常のクラスはこのクラスを通じてイベント送信を行えばよいです
	// Monostateなので注意
	public class GlobalEventSelector
	{
		private static var mDispatcher : IEventDispatcher;
		
		// イベント送付管理を行うインスタンスを登録します
		// 通常の状況ではsetupで一度だけDodontoSが登録されます
		// テスト時にはイベント受け取りのモックオブジェクトを登録します
		// それ以外の設定は行わないでください。
		public static function setGlobalEventDispatcher( dispatcher : IEventDispatcher ) : void
		{
			mDispatcher = dispatcher;
		}
	
		// グローバルなイベント受け取りを行うためのリスナーを追加します
		// 引数の意味はIEventDispatcherの物に従います
		// イベントリスナの生存管理はユーザコードにあります。
		// removeGlobalEventListenerを忘れず呼び出してください。
		public static function addGlobalEventListener(
			type : String,
			listener : Function,
			useCapture : Boolean = false,
			priority : int = 0,
			useWeakReference : Boolean = false
		) : void
		{
			mDispatcher.addEventListener( type, listener, useCapture, priority, useWeakReference );
		}
		
		// グローバルなイベントリスナの登録を解除します
		public static function removeGlobalEventListener(
			type : String,
			listener : Function,
			useCapture : Boolean = false
		) : void
		{
			mDispatcher.removeEventListener( type, listener, useCapture );
		}
		
		// グローバルなイベントリスなが登録済みか調べます
		public static function hasGlobalEventListener(
			type : String
		) : Boolean
		{
			return mDispatcher.hasEventListener( type );
		}
	}

}	// package app