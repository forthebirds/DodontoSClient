//--*-coding:utf-8-*--
package app.ui
{
	import mx.core.UIComponent;
    import mx.core.IFlexDisplayObject;
    import mx.managers.PopUpManager;

	public class MainPanel extends UIComponent
	{
		// メインパネル内にポップアップウィンドウを表示します
		// 戻り値は指定されたクラスであることが保証されるので
		// キャストして利用してください
		public function showPopup( className : Class ) : IFlexDisplayObject
		{
			return PopUpManager.createPopUp( this, className, false );
		}

		// メインパネルの中でモーダルなウィンドウを表示します
		// 戻り値は指定されたクラスであることが保証されるので
		// キャストして利用してください
		public function showModal( className : Class ) : IFlexDisplayObject
		{
			return PopUpManager.createPopUp( this, className, true );
		}
	}    
}	// package src.ui

