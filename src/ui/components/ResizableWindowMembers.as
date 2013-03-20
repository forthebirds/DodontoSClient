import mx.controls.Alert;
import mx.core.IFlexDisplayObject;
import mx.events.DragEvent;
import flash.events.MouseEvent;
import ui.components.IWindowSaveLoad;

// ---------------------------------------------------- static

// ウィンドウ状態のセーブ・ロード先
private static var sSaveLoad : IWindowSaveLoad;

// ウィンドウ状態のセーブ・ロード先を設定します
// すべてのResizableWindowの状態は
// ここで設定した対象にデータのセーブロードを行います
// すでに対象が設定されている場合は、新しいもので上書きされます
public static function setWindowSaveLoad( saveload : IWindowSaveLoad ) : void
{
	sSaveLoad = saveload;
}


// ---------------------------------------------------- ウィンドウの性質を決めるメンバ関数
// これらのメンバはサブクラスでオーバライドことにより、そのウィンドウの性質を変更します
// 容易な拡張のために準備されているメソッド類です

// ウィンドウのヘッダ部分の高さ
override protected function getHeaderHeight( ) : Number
{
	return 16;
}

// このウィンドウは縦にリサイズ可能か否か
// @retval true 縦にリサイズ可能
// @retval false 縦にリサイズ可能
public function isVerticalResizable( ) : Boolean
{
	return true;
}

// このウィンドウのリサイズ時最小サイズ
// この値よりも小さなサイズにはリサイズできません
// ただし直接値指定を行われた場合は例外で
// サイズが小さくなることがあります
protected function resizeMinSize( ) : Point
{
	return new Point( 100, 50 );
}


// 継承してウィンドウのセットアップ処理を行うことができます
// ただしオーバライドする場合は親クラスのsetupも必ず開始時に呼び出してください
protected function setup():void
{
}

// 指定されたセーブデータをウィンドウに復元する
// デフォルト実装ではx, y, width, height, visibleのデータを受け取り復元する
// オーバライド時対応するextractSaveDataを妥当なものにすることは継承先の責任です
protected function injectSaveData( saveData : Object ) : void
{
	this.x = saveData.x;
	this.y = saveData.y;
	this.width = saveData.width;
	this.height = saveData.height;
	this.visible = saveData.visible;
}

// セーブデータに利用するウィンドウ情報を獲得する
// この情報が実際のセーブデータには保存される
// デフォルト実装ではx, y, width, height, visibleが保存される
// オーバライド時対応するinjectSaveDataを妥当なものにすることは継承先の責任です
protected function extractSaveData( ) : Object
{
	var windowInfo : Object = new Object();

	windowInfo.x = this.x;
	windowInfo.y = this.y;
	windowInfo.width = this.width;
	windowInfo.height = this.height;
	windowInfo.visible = this.visible;

	return windowInfo;
}



// ---------------------------------------------------- イベント受信関連


// ウィンドウが生成されたときに１度だけ呼び出されるメソッド
private function creationComplete() : void
{
	// Resizerに自分を登録してリサイズ可能なウィンドウになる
	Resizer.addResize( this, resizeMinSize( ) );

	// ウィンドウの状態をセーブするか否か。
	// デフォルト値としてはtrueとし、セーブを行おうとする
	expectSaveWindowState = true;

	// 子クラスに生成のタイミングを与えるためにsetupを呼び出す
	setup( );

	// スキンをこのウィンドウに設定する
	// TODO: スキン機構の実装を行い、このコードを有効にする
	// TODO: あとそもそもUtils.setSkinでこのウィンドウのスキンが変わるのはおかしいのでスキン機構を見直す
	// Utils.setSkin(this);

	// ドラッグ操作用にタイトルバーのイベントを獲得可能にしておく
	titleBar.addEventListener( MouseEvent.MOUSE_UP, mouseUp );

	// マップのドラッグを停止させる
	// TDDO: このような密な連携を行うべきではないのでアーキテクチャ上では取り払うこと
	this.addEventListener(
			MouseEvent.MOUSE_UP,
			function():void
			{
				// DodontoF_Main.getInstance().getMap().stopDrag();
			}
	);
}

// ウィンドウの閉じるボタンを押した時に呼び出されるメソッド
public function closeEvent( ) : void
{
	toggleVisible();
}



// 表示状態の更新を行います
override public function set visible( v : Boolean ) : void
{
	// 一時領域に保存しておいて後でイベント発行の判断に用いる
	var temp : Boolean = this.visible;

	// 表示状態を更新
	super.visible = v;

	// 表示状態の変更があったのでウィンドウ状態を再セーブ
	saveWindowState();

	// 実際に更新が発生したかチェック
	if( temp != v )
	{
		// 表示状態が更新されたのでイベントを発行する
		sendChangeVisibleEvent();
	}
}

// 現在の表示状態を反転します。
// つまり表示していれば非表示に、
// 非表示なら表示にします
public function toggleVisible( ) : void
{
	this.visible = !this.visible;
}


// サイズ変更イベントの発行先関数
private var resizeEventFunction : Function = null;

// サイズ変更が発生したときに呼び出される関数を登録する
// 登録する関数は無引数であるべきで、戻り値は無視されます
public function setResizeEventFunction( f_ : Function ) : void
{
	resizeEventFunction = f_
}

// サイズ変更イベントをResizerから受信するためのメソッド
public function resizeEvent( ) : void
{
	saveWindowState();
	if( resizeEventFunction != null )
	{
		resizeEventFunction.call();
	}
}

// 移動イベントの発行先関数
private var moveEventFunction : Function = null;

// 移動イベントが発生したときに呼び出される関数を登録する
// 登録する関数は無引数であるべきで、戻り値は無視されます
public function setMoveEventFunction( f_ : Function ) : void
{
	moveEventFunction = f_;
}

// マウスクリックが終了したことを示すイベントを受け取るためのメソッド
public function mouseUp( event : MouseEvent ) : void
{
	// moveUpでは移動が発生したかもしれず
	// 実際に移動が発生した場合には
	// 1. ウィンドウ状態のセーブデータへの保存
	// 2. 移動イベントの発行
	// を行う
	
	saveWindowState();
	if( moveEventFunction !=  null )
	{
		moveEventFunction.call();
	}
}

// 表示・非表示変更イベントの発行先関数
private var changeVisibleEvent : Function = null;

// 表示・非表示変更イベントの発行先関数を登録する
// 登録する関数は１引数であるべきで、戻り値は無視されます
// 登録する関数の第一引数は、ウィンドウの更新後の表示・非表示状態です
public function setChangeVisibleEvent(function_:Function):void
{
	changeVisibleEvent = function_;
}

// 表示・非表示状態が更新されたことを示すイベントを受け取るためのメソッド
private function sendChangeVisibleEvent( ) : void
{
	if( changeVisibleEvent == null ) return;
	changeVisibleEvent( this.visible );
}

// セーブデータをロードし終わった後に発行されるイベント
private var saveDataLoadedEvent : Function = null;
// セーブデータをロードし終わった後であることを示すイベントの発行先関数を登録する
// 登録する関数は引数を１つ受けるべきで、戻り値は無視される
// 第一引数はロードしたセーブデータであることが保障されている
public function setSaveDataLoadedAction( func : Function ) : void
{
	saveDataLoadedEvent = func;
}


// ---------------------------------------------------- セーブロード関連

// このウィンドウではウィンドウ状態のセーブを行おうとするか否か
// trueでセーブを行おうとする
// ウィンドウがそもそもセーブに非対応の場合があり
// このフラグが立っているからといって必ずしもセーブが実施されるとは限らない
private var expectSaveWindowState : Boolean = false;

// この名前のセーブデータではセーブを行わない
// この文字列は空文字列であることが保障される
protected var KeyName_IgnoreSave : String = "";

// このウィンドウサイズを保存するときに利用するセーブデータ名
// KeyName_IgnoreSave以外ではセーブ処理が走る。
// これがKeyName_IgnoreSaveの時はセーブ処理はは知らない。
public function getSaveInfoKeyName():String
{
	return KeyName_IgnoreSave;
}

// このウィンドウは最後の表示位置情報をセーブデータに保存するか設定する
// この項目とは別にウィンドウごとに、
// そもそもの保存可能・不能の区分として、
// セーブデータ名があるかないか、という設定があるため
// ここをtrueにすると必ず保存可能になるわけではない点に注意
public function setEnableSavePosition(b:Boolean):void
{
	expectSaveWindowState = b;
}

// このウィンドウは最後の表示位置情報をセーブデータに保存するか
public function isEnableSavePosition( ) : Boolean
{
	// セーブ情報のキー名が無視指定の名前になっているならセーブしない
	if( getSaveInfoKeyName() == KeyName_IgnoreSave ) return false;

	// セーブしない設定になっていればセーブしない
	if( !expectSaveWindowState ) return false;

	return true;
}

// このウィンドウの現在の表示位置をセーブデータに保存する
// セーブしない設定になっているなら
// このメソッドは実際には何も実行しない
protected function saveWindowState():void
{
	// セーブしない設定になっているなら実行しない
	if( !isEnableSavePosition() ) return;

	// 獲得
	var data:Object = extractSaveData( );

	// セーブ。セーブ先がないなら無視
	if( sSaveLoad ) sSaveLoad.saveWindowState( getSaveInfoKeyName(), data );
}

// セーブデータ上のこのウィンドウの表示位置をロードし反映する
// セーブしない設定になっているなら
// このメソッドは実際には何も実行しない
// @return 実際にセーブデータをロードしたか否か
// @retval true セーブデータをロードした
// @retval false セーブデータをロードしなかった(できなかった)
public function loadWindowState():Boolean
{
	if( !isEnableSavePosition( ) ) return false;

	// セーブデータのロードを行う
	var saveData:Object = null;
	if( sSaveLoad ) saveData = sSaveLoad.loadWindowState( getSaveInfoKeyName() );
	if( saveData == null ) return false;

	// ロードされたセーブデータを使ってウィンドウ状態を更新する
	injectSaveData( saveData );

	// データロード後を示すイベントを発行する
	if( saveDataLoadedEvent != null )
	{
		saveDataLoadedEvent( saveData );
	}

	// TODO: 本当にこのタイミングでイベントを発行するの？injectSaveDataを子クラスに任せるのに？
	// 内部で状態更新があるだけで反映されるから２度発行になるけど気にしないの？
	// もしそれが正常ならなぜほかのイベントは発行しないの？
	sendChangeVisibleEvent();

	return true;
}

