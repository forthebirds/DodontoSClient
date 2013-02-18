package app.ui.menu 
{
	// メインメニューのカテゴリ「ヘルプ」を管理するクラス
	public class HelpMenuCategory implements IMenuCategory
	{
		// --------------------------------- IMenuCategory実装
		public function setModeDefault( ) : void
		{
		}
		
		public function setModeTiny( ) : void
		{
		}
		
		public function getChildren() : Array
		{
			return [
				{label:"バージョン", callback: onClickVersion },
				{label:"マニュアル", callback: onClickManual },
				{label:"チュートリアル動画", callback: onClickTutorialReplay },
				{label:"オフィシャルサイトへ", callback: onClickOfficialSite }
			];
		}
		
		// --------------------------------- コールバック実装
		
		private function onClickVersion( item : Object ) : void
		{
		}		
		
		private function onClickManual( item : Object ) : void
		{
		}
		
		private function onClickTutorialReplay( item : Object ) : void
		{
		}
		
		private function onClickOfficialSite( item : Object ) : void
		{
		}
		
	}
}	// package ui.menu

