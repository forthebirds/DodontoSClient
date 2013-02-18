package app.ui.menu 
{
	// メニューのメニューカテゴリ１つ分を表すクラス
	// メニューカテゴリとはメニューの中で１つの表示として出ている部分を指す
	public interface IMenuCategory 
	{
		// デフォルトモードに変更する
		function setModeDefault(  ) : void;
		
		// Tinyモードに変更する
		function setModeTiny(  ) : void;
		
		// 現在のモードにおけるこのメニューカテゴリの子要素たちを取得する
		// アレイのそれぞれの要素は１つ１つは、
		// そのメニューを選択した時に出てくる子要素の表現で、
		// mx:MenuBarのdataProviderでとるキーに加えてeventキーを取る。
		// eventキーには、イベントを設定すると、この項目が選択されたときに、
		// そのイベントをMainMenuからdispatchEventする。
		// そのほかの値はmx:MenuBarの仕様に従う。
		function getChildren() : Array;
	}
}