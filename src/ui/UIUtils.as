package ui 
{	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	
	// UI表示関連のユーティリティメソッドを持つクラス
	// インスタンス化せずに直接利用することを想定されています。
	public class UIUtils 
	{	
		// アラートダイアログを表示し、ユーザにOK, CANCELの問い合わせを行います。
		// OKの場合のみ指定された関数を実行します
		// @param title アラートダイアログのタイトル
		// @param question ユーザに問い合わせる質問
		// @param action ユーザがOK応答の時に実行する関数
		// @return OKが押されたか否か。trueでOKだった。
        static public function askByAlert(
			title : String,
			question : String,
			action : Function
		) : Boolean 
		{
			var isOK : Boolean = false;
			Alert.show(
				question, title, 
				Alert.OK | Alert.CANCEL, null, 
				function(e : CloseEvent) : void
				{
					if (e.detail == Alert.OK) {
						isOK = true;
						if( action != null ) action();
					}
				}
			);

			return isOK;
        }
	}
}	// package ui
