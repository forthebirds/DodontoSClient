
package ui.components
{

// セーブデータ書き出し先は直接の依存を行わなくて済むように
// このISaveLoadインタフェイスを用いて行う
public interface IWindowSaveLoad
{
	// 指定されたキーに関連付けられた
	// ウィンドウ状態のセーブデータをロードし
	// オブジェクトの形にして返します
	function loadWindowState( key : String ) : Object;

	// 指定されたキーに対して
	// 指定されたウィンドウ状態のセーブデータを関連付けて保存します
	function saveWindowState( key : String , saveData : Object ) : void;
}

}	// package ui.components


