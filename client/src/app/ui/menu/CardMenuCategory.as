package app.ui.menu
{
	import app.Events;
	import flash.events.Event;
	// メインメニューのカテゴリ「コマ」を管理するクラス
	public class CardMenuCategory implements IMenuCategory
	{
		private var mSetCardsPickupVisibility : Object = {
			label:"カードピックアップウィンドウ表示",
			event: new Event( Events.REQ_SET_CARDS_PICKUP_VISIBILITY ),
			type:"check",
			toggled:false
		};
		
		private var mInitCardsPosture : Object = {
			label:"カード配置の初期化",
			event: new Event( Events.REQ_INIT_CARDS_POSTURE )
		};
	
		private var mCleanCards : Object = {
			label:"カードの全削除",
			event: new Event( Events.REQ_CLEAN_CARDS )
		};
		
		// --------------------------------- IMenuCategory実装
		
		// モード間の違いがないので無実装(安全にするなら空なchildrenを返すようにしてもいいけど、それは趣味。)
		public function setModeDefault( ) : void { }
		public function setModeTiny( ) : void { }

		// 
		public function getChildren() : Array
		{
			return [
				mSetCardsPickupVisibility,
				{type:"separator"},
				mInitCardsPosture,
				{type:"separator" },
				mCleanCards
			];
		}		
	}
}	// package ui.menu

