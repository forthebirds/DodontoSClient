// MainMenuから<mx:Script />で呼び出されることを想定している
// そのためここにあるコードはMainMenuのメンバだと考えてよい

import app.Events;
import flash.events.Event;
import mx.controls.Alert;
import mx.events.MenuEvent;
import app.ui.menu.IMenuCategory;

import app.ui.menu.FileMenuCategory;
import app.ui.menu.DisplayMenuCategory;
import app.ui.menu.PieceMenuCategory;
import app.ui.menu.CardMenuCategory;
import app.ui.menu.MapMenuCategory;
import app.ui.menu.ImageMenuCategory;
import app.ui.menu.HelpMenuCategory;

// ---------------------------------------------------- Public

// メニュー項目をすべてクリアします
public function clearMenus( ) : void
{
	mMenuItems = null;
}

// デフォルトのメニュー項目を読み込みます
public function setModeDefault( ) : void
{
	for each( var category : IMenuCategory in mCategories )
	{
		category.setModeDefault( );
	}
	
	mMenuItems =  [
		{ label:"ファイル", children: mFileCategory.getChildren() },
		{ label:"表示", children: mDisplayCategory.getChildren() },
		{ label:"コマ", children: mPieceCategory.getChildren() },
		{ label:"カード", children: mCardCategory.getChildren() },
		{ label:"マップ", children: mMapCategory.getChildren() },
		{ label:"画像", children: mImageCategory.getChildren() },
		{ label:"ヘルプ", children: mHelpCategory.getChildren() }
	];
}

// Tinyモードのメニュー項目を読み込みます
public function setModeTiny( ) : void
{
	for each( var category : IMenuCategory in mCategories )
	{
		category.setModeTiny( );
	}
	
	mMenuItems = [
		{ label:"ファイル", children: mFileCategory.getChildren( ) },
		{ label:"表示", enabled:"true", children: mDisplayCategory.getChildren( ) },
		{ label:"画像", children: mImageCategory.getChildren( ) },
	];
}

// ---------------------------------------------------- Private

// MainMenuのメニュー項目を示す配列です
// この情報を設定することによって
// メニュー項目が動的に切り替わります
// 
// 影響がとても大きいのでpublicにするなよ？ぜーったいするなよ？
// やりたい操作があったらその操作は何か考えたうえでMainMenuにメソッド準備すること。
[Bindable] private var mMenuItems : Array;

// メニューカテゴリ
private var mFileCategory : FileMenuCategory; // ファイル
private var mDisplayCategory : DisplayMenuCategory; // 表示
private var mPieceCategory : PieceMenuCategory; // コマ
private var mCardCategory : CardMenuCategory; // カード
private var mMapCategory : MapMenuCategory; // マップ
private var mImageCategory : ImageMenuCategory; // 画像
private var mHelpCategory : HelpMenuCategory; // ヘルプ

// カテゴリはまとめて操作したいことがあるので全部この中に入れておく
private var mCategories : Array;
	
// --------------------------- イベント関連
private function onCreationComplete():void
{	
	mFileCategory = new FileMenuCategory( );
	mDisplayCategory = new DisplayMenuCategory( );
	mPieceCategory = new PieceMenuCategory( );
	mCardCategory = new CardMenuCategory( );
	mMapCategory = new MapMenuCategory( );
	mImageCategory = new ImageMenuCategory( );
	mHelpCategory = new HelpMenuCategory( );
	
	mCategories =  [
		mFileCategory,
		mDisplayCategory,
		mPieceCategory,
		mCardCategory,
		mMapCategory,
		mImageCategory,
		mHelpCategory
	];
}

// メニュー項目が選択されたときに発生するイベント
private function onSelectMenuItem( ev : MenuEvent ) : void
{
	if ( ev.item == null ) return;
	
	if ( ev.item.hasOwnProperty( "event" ) )
	{
		var event : Event = ev.item.event;
		if ( event != null ) dispatchEvent( event );
	}
}

// メニューのログアウトボタンがクリックされたときに発生するイベント
private function onClickLogoutButton( ) : void
{
	dispatchEvent( new Event( Events.REQ_LOGOUT ) );
}