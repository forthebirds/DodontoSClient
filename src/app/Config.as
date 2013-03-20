//--*-coding:utf-8-*--
package app
{
	import mx.effects.Glow;

	public class Config
	{
		// ------------------------------------- Static method
		
		// シングルトンインスタンスを取得します
		public static function getInstance( ) : Config
		{
			if( sInstance == null )
			{
				sInstance = new Config( new Dummy() );
			}
			return sInstance;
		}

		// ------------------------------------- Public method

		// コンストラクタ
		// ConfigはSingletonです。Dummyクラスのインスタンスを受けますが
		// このDummyクラスは本当にダミーなinner classで
		// 外部からの生成を禁止しています
		public function Config( dummy : Dummy )
		{
			dummy = null;
		}

		// Application.application.parametersをConfigに設定します
		// DodontoS.mxmlのsetupから起動時に一度だけ呼ばれる想定です
		public function setParameters( params : Object ) : void
		{
			mModes = new Modes( params["modes"] );
		}

		// この「どどんとす」の現在のモード情報を取得します
		public function getModes( ) : IModes
		{
			return mModes;
		}

		// この「どどんとす」のバージョン文字列を取得します
		public function getVersion( ) : String
		{
			return "Ver.0.00.01(2013/02/10)";
		}

		// 通常のグローエフェクト設定を取得します
		public function getNormalGlowEffect( ) : Glow
		{
			return mGlowSettings.normalGlowEffect;
		}
		
		// 画像リサイズを行うか否かのデフォルト値(?)
		// TODO: 上記コメントは嘘かもしれない。この値の意味を竹流さんに問う
        public static function isAdjustImageSizeDefault():Boolean
		{
            return true;
        }

		// ------------------------------------- variables
		private static var sInstance:Config;
		private var mSaveDataKey:String = "DodontoS_LocalSaveData";
		private var mGlowSettings:GlowSettings = new GlowSettings( );
		private var mModes:IModes = new NullModes( );
	}
}	// package

// ----------------------------- innner class

interface IModes
{
	// GaeJavaModeであるか
	// TODO: このコメントは意味をなさない。GaeJavaModeとは何か調査しコメントしなおす
	function isGaeJavaMode( ) : Boolean;

	// TinyModeであるか
	// TODO: このコメントは意味をなさない。TinyModeとは何か調査しコメントしなおす
	function isTinyMode( ) : Boolean;

	// RailsModeであるか
	// TODO: このコメントは意味をなさない。RailsModeとは何か調査しコメントしなおす
	function isRailsMode( ) : Boolean;

	// MySQLModeであるか
	// TODO: このコメントは意味をなさない。MySQLModeとは何か調査しコメントしなおす
	function isMySqlMode( ) : Boolean;

	// ErrorLogModeであるか
	// TODO: このコメントは意味をなさない。ErrorLogModeとは何か調査しコメントしなおす
	function isErrorLogMode():Boolean;

	// TuningLogModeであるか
	// TODO: このコメントは意味をなさない。TuningLogModeとは何か調査しコメントしなおす
	function isTuningLogMode():Boolean;

	// DebugLogModeであるか
	// TODO: このコメントは意味をなさない。DebugLogModeとは何か調査しコメントしなおす
	function isDebugLogMode():Boolean;

	// AdminModeであるか
	// TODO: このコメントは意味をなさない。AdminModeとは何か調査しコメントしなおす
	function isAdminMode():Boolean;
}

// IModesのNullObjectです
// 動作チェックを不要にするため、すべてのモードでfalseを返しつつ動作します
class NullModes implements IModes
{
	// ------------------------- IModesを実装
	public function isGaeJavaMode( ) : Boolean { return false; }
	public function isTinyMode( ) : Boolean { return false; }
	public function isRailsMode( ) : Boolean { return false; }
	public function isMySqlMode( ) : Boolean { return false; }
	public function isErrorLogMode():Boolean { return false; }
	public function isTuningLogMode():Boolean { return false; }
	public function isDebugLogMode():Boolean { return false; }
	public function isAdminMode():Boolean { return false; }
}

// DodontoFの動作モードを管理するクラスです
// 各種モードの定義を明らかにし、各種モードが現在どのモードにあるのかの値を返します
class Modes implements IModes
{
	// ------------------------------------- Public method

	// コンストラクタ
	// @param modeString モード文字列を','で区切った文字列。内部でパースされます
	public function Modes( modeString : String )
	{
		// modeStringがないということは何もモードが指定されていない
		// この時すべてのモードは無効。
		// これについてはアサーションのほうがよい可能性あり。
		if ( modeString == null )
		{
			mModes = [];
			return;
		}
		
		// modeStringはコロン区切りでモード指定文字列が入っている
		// ここに含まれる文字列をmModesとして保存しておく
		mModes = modeString.split(/,/);
	}

	// ------------------------- IModesを実装(コメントはIModes参照)

	public function isGaeJavaMode( ) : Boolean { return COMPILE::isGaeJava; }
	public function isTinyMode( ) : Boolean { return isMode("tiny"); }
	public function isRailsMode( ) : Boolean { return isMode('Rails'); }
	public function isMySqlMode( ) : Boolean
	{
		// コンパイル時定数としてisMySqlが指定されているなら
		// filedbを明示的にモードとして指定されない限りMySQLモードだ
		if( COMPILE::isMySql )
		{
			var isMySql : Boolean = !isMode('filedb');
			return isMySql;
		}
		// mysqlモードかチェック
		return isMode('mysql');
	}
	public function isErrorLogMode():Boolean { return isMode('errorLog'); }
	public function isTuningLogMode():Boolean { return isMode('tuningLog'); }
	public function isDebugLogMode():Boolean { return isMode('debugLog'); }
	public function isAdminMode():Boolean { return isMode('admin'); }

	// ------------------------------------- private variables
	private var mModes : Array;	// 有効なモードのリスト

	// ------------------------------------- Private method

	// 現在設定されているパラメタのモード値が
	// 指定されたモードであるかどうかをチェックして返します
	// @param targetMode 調べる対象のモード文字列
	// @return 指定されたモードであるか否か
	// @retval true 指定されたモードである
	// @retval false 指定されたモードではない
	private function isMode( targetMode : String ) : Boolean
	{
		// mModesをすべて列挙する
		// この中に指定されたモード文字列があれば
		// そのモードは有効
		for( var i : int = 0; i < mModes.length ; ++i )
		{
			// モード文字列
			if( mModes[i] == targetMode ) return true;
		}

		// 何も引っかからないので
		// 指定されたモードは無効だ
		return false;
	}
}

// Configをシングルトン化するためのダミー引数用クラス
class Dummy
{

}
