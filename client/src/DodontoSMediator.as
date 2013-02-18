//--*-coding:utf-8-*--
package {

	import app.Events;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import mx.controls.Menu;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import mx.controls.treeClasses.TreeItemRenderer;

	import app.Config;
	import app.URLS;
	import app.Session;
	import app.WindowSaveData;

	import app.ui.MainPanel;
	import app.ui.menu.MainMenu;
	import app.ui.LoginWindow;
	
	import app.ui.LogWindow;

	import ui.components.ResizableWindow;

	// DodontoS全体の最終的な結合を行い
	// 全体の管理と協調のための作業を行うクラスです
	// このクラスはシングルトンです。
	//
	// このクラスは肥大化しやすいので極力コードを追加せず
	// あくまで実作業は各コンポネントに任せるようにします。
	// また汎用化の可能性を見つけるごとに小さなクラスに分割するべきです。
	public class DodontoSMediator
	{
		// ------------------------------------- Static method

		public static function getInstance() : DodontoSMediator
		{
			if( sInstance == null )
				sInstance = new DodontoSMediator( new Dummy() );
			return sInstance;
		}

		// ------------------------------------- Public method

		// コンストラクタ
		// ConfigはSingletonです。Dummyクラスのインスタンスを受けますが
		// このDummyクラスは本当にダミーなinner classで
		// 外部からの生成を禁止しています
		public function DodontoSMediator( dummy : Dummy )
		{
		}

		// アプリケーション開始時に一度だけ呼ばれて
		// 各モジュールの設定と初期化を済ませるメソッド
		public function setup( dodontos : DodontoS ) : void
		{
			// パラメタ情報を引き出しておく
			var conf : Config = Config.getInstance();
			conf.setParameters( dodontos.parameters );

			// リサイズ可能ウィンドウ類モジュールをつかえるようにする
			// セーブデータの読み込み・書き込みを可能にする
			ResizableWindow.setWindowSaveLoad(
				new WindowSaveData( conf.getModes().isTinyMode() )
			);

			// 各領域の引き出しと保存を行っておく
			// DodontoSに直接依存することはないはず
			mMainMenu = dodontos.mainMenu;
			mMainPanel = dodontos.mainPanel;
			
			// イベント受け取りを登録する
			setupEventListeners( );

			// セッションを生成しておく
			mSession = new Session( );

			// デバッグログモードならデバッグログウィンドウを出しておく
			if ( conf.getModes().isDebugLogMode( ) )
			{
				mMainPanel.popup( LogWindow );
			}
			
			// ログインを行う
			// TODO: とりあえずこれは動作チェック用なので本番に向けて変更していくこと
			login( );
		}

		// ------------------------------------- Private method
		
		private function setupEventListeners( ) : void
		{
			// イベント受け取りを設定する
			mMainMenu.addEventListener( Events.REQ_LOGOUT, onSelectLogout );
		}
			
		private function login( ) : void
		{
			mMainPanel.popup( LoginWindow );
		
			// 「セッション」クラスは
			// 待ちを出すわけでもないしLoginWindowからの
			// コールバック待ちになるのではないかな?
			// mSession. ...
			
			// ------------------------ ここ以下は本来ログイン完了のコールバック内のセッション内部で行う
			
			// コンフィグ引き出し
			var conf : Config = Config.getInstance();
			
			// ログインできた。メインメニューをデフォルトモードで有効化する
			// TODO: とりあえずこれは動作チェック用なので本番に向けて変更していくこと。受けるのはmSession側じゃないか？
			if ( conf.getModes().isTinyMode() )
			{
				mMainMenu.setModeTiny( );
			} else
			{
				mMainMenu.setModeDefault( );
			}
			mMainMenu.enabled = true;
		}

		private function onSelectLogout( ev : Event ) : void
		{
			// このメソッドはおそらくSessionクラスが本来は持つ

			// 今のURLに再ログイン
			var url : String = URLS.getLogoutURL( );
			var request : URLRequest = new URLRequest( url );
			navigateToURL( request, "_self" );
		}

		// ------------------------------------- variables

		// シングルトンインスタンス
		static private var sInstance : DodontoSMediator = null;

		// DodontoSのメインメニュー
		private var mMainMenu : MainMenu;

		// DodontoSのメインパネル
		// 主なコンテンツを配置する一番広い領域
		private var mMainPanel : MainPanel;

		// 接続セッション。ログインしてログアウトするまで一連の接続情報を確保する
		private var mSession : Session;
	}

}	// package



// 外部のコンストラクタ呼び出しを禁止するためのダミークラス
class Dummy
{
}
