import mx.collections.ArrayCollection;
import mx.containers.TitleWindow;
import mx.controls.Alert;
import mx.core.IFlexDisplayObject;
import mx.events.CloseEvent;
import mx.events.DataGridEvent;
import mx.events.ListEvent;
import mx.events.MenuEvent;
import mx.managers.PopUpManager;

import ui.UIUtils;

// これがここにimportされるのはおかしいので修正を入れていく
import app.Config;
import app.URLS;


// ---------------------------------------------------- Private

// プレイルームの情報を表示する表のそれぞれのカラムデータ
[Bindable] private var playRoomStates : ArrayCollection = new ArrayCollection();

// メニュー項目を示す配列です
// この情報を設定することによって
// メニュー項目が動的に切り替わります
[Bindable] private var mMenuArray : Array;

// プレイルームの一括消去対象になる保存日数。この値よりも大きい日数の部屋が対象になる。
// TODO: この名称は違う。おそらく生存日数を意味する言葉に置き換えたほうがよいだろう
[Bindable] private var removeOldPlayRoomLimitDays : Number = 0;

private var playRoomGetRangeMax:int = 10;
private var playRoomGetRange:int = 10;
private var maxRoom:int = 0;
private var minRoom:int = 0;

private var defaultUserName : String = "ななしさん";
private var defaultUserNames : Array = [ defaultUserName ];

private var extendMode:Boolean = false;
private var playRoomStatesList:Object = new Object( );

private var totalLoginCountLimit:int = -1;

private var showLoginLineMax:int = 10;
private var showLoginCountPerLine:int = 1;

private var loginUserCountList:Object;
private var isNeedCreatePassword:Boolean = false;


protected override function setup( ) : void
{
	super.setup( );	// setupのオーバライドでは親のsetup呼び出しが必須

	// sendLoginRequest( ); ここで送るものじゃないよね？モデルで送る。

	loadPlayerInfo( );
	
	// メニュー構成を作成
	mMenuArray = getMenu( );
	
	// AdminModeかそうではないかで見た目を変える部分を反映する
	applyAdminMode( );
}

public function removeOldPlayRooms( ) : void
{
	UIUtils.askByAlert(
		"一括削除確認",
		removeOldPlayRoomLimitDays + "日以上前の、古いプレイルームの一括削除を行います。\nよろしいですか？",
		function( ) : void
		{
			// TODO: 送信処理を書く
			/*
			guiInputSender.removeOldPlayRoom(
				function(event:Event=null):void {
					playRoomStatesList = new Object();
					getPlayRoomStates();
				}
			);
			*/
		}
	);
}


public function onClickRemovePlayRoom( ) : void
{
	var indices : Array = playRoomStateInfo.selectedIndices;

	if ( indices == null ) return;
	if ( indices.length == 0 ) return;

	var message : String = "";
	var roomNumbers : Array = new Array();
	for each( var index : int in indices )
	{
		var roomNumber : int = getRoomNumberByIndex( index );
		// TODO: guiInputSender.checkRoomNumber( roomNumber );

		var roomName : String = getRoomNameByIndex( index );
		message += "No." + roomNumber + "：" + roomName + "\n";

		roomNumbers.push( roomNumber );
	}

	// TODO: guiInputSender.checkRoomNumber( roomNumber );

	message += "を削除しますか？";
	removePlayRoomWithMessage( roomNumbers, message );
}

public function removePlayRoomWithMessage(
	roomNumbers:Array,
	message:String,
	ignoreLoginUser:Boolean = false,
	password:String = ""
) : void
{
	UIUtils.askByAlert(
		"削除確認", message,
		function( ) : void
		{
			// TODO:
			/*
			guiInputSender.removePlayRoom(
				roomNumbers,
				removePlayRoomResult,
				ignoreLoginUser,
				password
			);
			*/
		}
	);
}

public function removePlayRoomResult( event : Event ) : void
{
	// TODO:
	/*
	var jsonData : Object = SharedDataReceiver.getJsonDataFromResultEvent(event);
	
	reloadDeletedPlayRoom( jsonData.deletedRoomNumbers );
	askDeletePlayRoom( jsonData.askDeleteRoomNumbers );
	inputPaswordToDeletePlayRoom( jsonData.passwordRoomNumbers );
	printErrorMessageForDeletePlayRom( jsonData.errorMessages );
	*/
}


// 拡張機能モードを切り替えます
public function flipExtendMode( ) : void
{
	extendMode = !extendMode;
	
	if ( extendMode )
	{
		extendButton.label = "＜＜拡張機能を隠す";
		extendBox.height = 30;
		extendBox.visible = true;
	} else
	{
		extendButton.label = "＞＞拡張機能";
		extendBox.height = 0;
		extendBox.visible = false;
	}
}

public function requestPlayRoomStates( ) : void
{
	// TODO: リクエスト送信
}

public function applyPlayRoomStates( ) : void
{
	var index:int = playRoomStateTabs.selectedIndex;
	// applyPlayRoomStatesByIndex(index);
}


public function checkRoomStatusResult( obj : Object ) : void
{
	// TODO: この問い合わせ結果解析をクラスに分解
	/*
	Log.logging("LoginWindow.checkRoomStatusResult begin");
	try{
		enableLoginButton();
		
		var jsonData:Object = SharedDataReceiver.getJsonDataFromResultEvent(obj);
		
		var isRoomExist:Boolean = jsonData.isRoomExist;
		Log.logging("isRoomExist", isRoomExist);
		
		var roomNumber:int = jsonData.roomNumber;
		var roomName:String = jsonData.roomName;
		var chatChannelNames:Array = jsonData.chatChannelNames;
		var canUseExternalImage:Boolean = jsonData.canUseExternalImage;
		var canVisit:Boolean = jsonData.canVisit;
		var isPasswordLocked:Boolean = jsonData.isPasswordLocked;
		
		Log.logging("roomNumber", roomNumber);
		Log.logging("roomName", roomName);
		Log.logging("chatChannelNames", chatChannelNames);
		Log.logging("canUseExternalImage", canUseExternalImage);
		Log.logging("canVisit", canVisit);
		Log.logging("isPasswordLocked", isPasswordLocked);
		
		DodontoF_Main.getInstance().setMentenanceModeOn( jsonData.isMentenanceModeOn );
		DodontoF_Main.getInstance().setWelcomeMessageOn( jsonData.isWelcomeMessageOn );
		DodontoF_Main.getInstance().setUseExternalImage( canUseExternalImage );
		
		var enterPlayRoomFunction:Function = getEnterPlayRoomFunction(roomNumber, roomName, chatChannelNames);
		
		if( ! isRoomExist ) {
			var createPlayRoomWindow:CreatePlayRoomWindow = DodontoF.popup(CreatePlayRoomWindow, true) as CreatePlayRoomWindow;
			createPlayRoomWindow.initParams(roomNumber, isNeedCreatePassword, enterPlayRoomFunction);
			
			return;
		}
		
		//パスワード無しで見学無しならそのままログイン
		if( ! isPasswordLocked ) {
			if( ! canVisit ) {
				enterPlayRoomFunction();
				return;
			}
		}
		
		//パスワードか見学ありの場合
		var window:InputPlayRoomPasswordWindow = DodontoF.popup(InputPlayRoomPasswordWindow, true) as InputPlayRoomPasswordWindow;
		window.init(roomNumber, roomName, canVisit, isPasswordLocked, enterPlayRoomFunction);
	} catch(error:Error)
	{
		status = error.message;
	}
	*/
}







private function applyApplicationSettings( settings : Object ) : void
{
	// FPS設定に従う
	stage.frameRate = settings.getFPS( );
	
	playRoomGetRangeMax = settings.playRoomGetRangeMax;
	setMaxPlayRoomNumber( settings.playRoomMaxNumber );
	loginMessage.htmlText = settings.loginMessage;
	removeOldPlayRoomLimitDays = settings.removeOldPlayRoomLimitDays;
	setDefaultUserNames( settings.defaultUserNames );
	
	enableLoginButton( );
	extendButton.enabled = true;
	
	applyPlayRoomStates( );
}

private function enableLoginButton( b : Boolean = true ) : void
{
	loginButton.enabled = b;
	playRoomStateInfo.enabled = b;
	createPlayRoomButton.enabled = b;
	removePlayRoomButton.enabled = b;
	playRoomStateTabs.enabled = b;
}

private function analyzeLoginUserCounts( jsonData : Object ) : Boolean
{
	loginUserCountList = jsonData.loginUserCountList as Array;
	currentAllLoginUserCounts.label = getLoginCountInfo( jsonData );
	return checkLoginCount( jsonData );
}

// このメソッドの所在はログイン状況関連を管理する別人かもね。表示はここだろうけど。
private function checkLoginCount( jsonData : Object ) : Boolean
{
	var countInfo : String = getLoginCountInfo( jsonData );
	
	if ( isValidLimitLoginCount( jsonData ) )
	{
		if ( jsonData.allLoginCount > jsonData.limitLoginCount )
		{
			var message:String = "ログイン人数が限界です。\n　　【" + countInfo + "】\n他のサーバをご利用ください。";
			status = message.replace(/　/g, '').replace(/\n/g, '　');
			Alert.show(message);
			return false;
		}
	}
	
	if( jsonData.allLoginCount < jsonData.maxLoginCount ) {
		return true;
	}
	
	status = "ログイン人数が多くなってきました。【" + countInfo + "】他のサーバの利用を検討ください";
	return true;
}


private function getDefaultName( ) : String
{
	// TODO: 乱数の獲得方法を作成する。
	var index : int = 0; // TODO: Dice.getRandomNumber( defaultUserNames.length ) - 1;
	var name : String = defaultUserNames[ index ];
	return name;
}

private function getMenu( ) : Array
{
	return [
		{
			label:"ヘルプ", data:"pass",
			children: [
				{label:"バージョン", data:"version"},
				{label:"マニュアル", data:"manual"},
				{label:"チュートリアル動画", data:"tutorialReplay"},
				{label:"オフィシャルサイトへ", data:"officialSite"}
			]
		}
	];
}

private function selectMenu( event : MenuEvent ) : void
{
	// TODO: DodontoF_Main.getInstance().getDodontoF().selectMenu(event);
}

// グローバルコンフィギュレーションのAdminModeの状態を
// このログインウィンドウの見た目に反映します
// モードの切り替え後、このメソッドが適切に呼び出されるようにしてください。
private function applyAdminMode() : void
{
	// AdminModeのときだけ以下のコードを実行し
	// AdminMode用のデザインになる
	if( Config.getInstance( ).getModes( ).isAdminMode() )
	{
		// AdminModeの時

		playerNameSpace.width = 0;
		
		adminPassword.percentHeight = 100;
		adminPassword.width = 100;
		adminPassword.enabled = true;
		
		broadCastMessageBox.height = 50;
		broadCastMessageBox.visible = true;
		broadCastMessageBox.enabled = true;
		
		broadCastMessageName.visible = true;
		broadCastMessageName.enabled = true;
		
		broadCastMessageText.visible = true;
		broadCastMessageText.enabled = true;
		
		broadCastMessageButton.visible = true;
		broadCastMessageButton.enabled = true;
	}else
	{
		// AdminModeではない時
		playerNameSpace.width = 50;
		
		adminPassword.percentHeight = 0;
		adminPassword.width = 0;
		adminPassword.enabled = false;
		
		broadCastMessageBox.height = 0;
		broadCastMessageBox.visible = false;
		broadCastMessageBox.enabled = false;
		
		broadCastMessageName.visible = false;
		broadCastMessageName.enabled = false;
		
		broadCastMessageText.visible = false;
		broadCastMessageText.enabled = false;
		
		broadCastMessageButton.visible = false;
		broadCastMessageButton.enabled = false;
	}
}

// 管理者モード時、全部屋へ一斉に発言を行います
private function sendMessageAll( ) : void
{
	// TODO: 全体に送信するためのAPIをコール
	/*
	guiInputSender.sendChatMessageAll(
		broadCastMessageName.text,
		broadCastMessageText.text,
		adminPassword.text
	);
	*/
	
	// 発言を送信したのでクリアしておく
	broadCastMessageText.text = "";
}

// プレイルーム情報欄をクリックした時のイベントハンドラ
private function onClickPlayRoomStateInfo( ) : void
{
	// クリックして選択中になっているはずなので、その部屋番号を取得
	var index : int = getSelectedRoomNumber( );
	// -1になるのは異常なので何もしない
	if( index == -1 ) return;
	// ルーム番号をルーム番号入力欄に転写しておく
	roomNumberInput.text = "" + index;
}

// プレイルーム情報欄の上にマウスカーソルを重ねた時のイベントハンドラ
private function onRollOverPlayRoomStateInfo( event : ListEvent ) : void
{
	// イベントから対象のプレイルーム情報欄のインデクスを獲得
	// このインデクスはグリッド内でのインデクスで
	// サーバでのルームインデクスとは別なので注意
	var index : int = event.rowIndex;

	// プレイルーム情報欄のインデクスを使ってログインユーザ情報を引き出す
	var loginUsers : Array = playRoomStates[index].loginUsers as Array;

	// 引き出したログインユーザ情報からツールチップを新たに表示する
	playRoomStateInfo.toolTip = "ログインユーザー：" + loginUsers.join("  ");
}

// プレイヤー情報の更新を行う
// プレイヤー名入力欄に変更があったときに呼ばれる
private function savePlayerInfo( ) : void
{
	/*
	var name : String = playerName.text;
	ChatWindow.savePlayerInfo(name);
	ChatWindow.setDefaultCharacterName(name);
	*/
}

private function loadPlayerInfo( ) : void
{
	playerName.text = loadDefaultCharacterName();
	savePlayerInfo();
}

private function loadDefaultCharacterName():String
{
	// TODO: チャット欄に入力したプレイヤ情報から獲得しているが、これはプレイヤ情報のモデルから獲得するようにしたい
	// TODO: つーか、さっさとモデル置き場を作りたいね！
	var info : Object = null; // ChatWindow.getPlayerInfo( );

	if( info == null ) return getDefaultName();
	
	// キャラクタ名を獲得して、内容があるなら反映する
	var name : String = info["characterName"];

	if( name == null ) return getDefaultName();
	if( name == defaultUserName ) return getDefaultName();
	
	return name;
}


private function setDefaultUserNames( names : Array ) : void
{
	if( names.length == 1 )
	{
		if( names[ 0 ] == defaultUserName )
		{
			return;
		}
	}
	
	defaultUserNames = names;
	playerName.text = loadDefaultCharacterName();
}

private function saveUniqeId( uniqueId : String ) : void
{
	// TODO:
	/*
	var loginInfo:Object = Config.getInstance().loadLoginInfo();
	if( loginInfo == null ) {
		loginInfo = new Object();
	}
	
	loginInfo.uid1 = uniqueId;
	
	Config.getInstance().saveLoginInfo( loginInfo );
	*/
}


// ルーム情報リストのインデクス番号からルーム番号に変換を行います
private function getSelectedRoomNumber( ) : int
{
	var index : int = playRoomStateInfo.selectedIndex;
	if(index == -1) {
		return -1;
	}
	
	return getRoomNumberByIndex( index )
}

// 現在の表示状態を加味して
// ルーム情報リストのインデクス番号からサーバルーム番号への変換を行います
// @param index ルーム情報リスト上のインデクス番号
// @return サーバルーム番号
private function getRoomNumberByIndex( index : int ) : int
{
	return playRoomStates[index].index
}

private function getSelectedRoomName( ) : String
{
	var index:int = playRoomStateInfo.selectedIndex;
	if ( index == -1 )
	{
		return "";
	}
	return getRoomNameByIndex(index);
}

private function getRoomNameByIndex( index : int ) : String
{
	return "" + playRoomStates[index].playRoomName;
}

private function isInvalidVersion( serverVersion : String ) : Boolean
{
	var clientVersion:String = Config.getInstance().getVersion();
	if ( clientVersion == serverVersion )
	{
		return false;
	}
	
	var message:String = "";
	message += "サーバCGIとクライアントFlashのバージョンが異なります。\n";
	message += "Flashの読み込みに失敗していると思われます。\n";
	message += "ブラウザをリロードしてFlashの再読み込みを行ってください。\n";
	message += "サーババージョン　　　：" + serverVersion + "\n";
	message += "クライアントバージョン：" + clientVersion + "\n";
	
	Alert.show(message);
	
	return true;
}



private function checkLoginInfoResult( jsonData : Object ) : Boolean
{
	// TODO:
	/*
	if ( isInvalidVerson( jsonData.version ) )
	{
		return false;
	}
	
	var warningMessage:String = Messages.getMessageFromWarningInfo(jsonData.warning);
	if ( warningMessage != "" )
	{
		Alert.show(warningMessage);
		return false;
	}
	return true;
	*/
	return false;
}



private function getLoginCountInfo(jsonData:Object):String {
	var count:int = jsonData.allLoginCount;
	var max:int = jsonData.maxLoginCount;
	
	//var percentage:int = getLoginCountPercentage(jsonData);
	//var message:String = "" + percentage + "%(" + count  + "/" + max + ")";
	
	var message:String = "" + "現状：" + count  + "人";
	if( isValidLimitLoginCount(jsonData) ) {
		message += "／" + "上限：" + jsonData.limitLoginCount + "人";
	}
	
	return message;
}

private function isValidLimitLoginCount(jsonData:Object):Boolean {
	if( jsonData.limitLoginCount == null ) {
		return false;
	}
	
	return ( jsonData.limitLoginCount >= 0 );
}
/*
private function getLoginCountPercentage(jsonData:Object):int { 
	var count:int = jsonData.allLoginCount;
	var max:int = jsonData.maxLoginCount;
	
	var percentage:int = 100.0 * count / max;
	
	return percentage;
}
*/


private function showLoginUserCounts( ) : void
{
	// ログインユーザ数のリストが空(まだ応答を受けていない)なら何も反応しない
	if( loginUserCountList == null ) return;

	// ログイン情報を収集し表示するためのテキスト
	var loginInfoText : String = "";
	// 表示する最大部屋数。
	// これを超える場合は"..."と末尾に表示され、残りは省略
	var maxCount : int = showLoginLineMax * showLoginCountPerLine;
	
	for( var i : int = 0; i < loginUserCountList.length; i++ )
	{	
		loginInfoText += getLoginCountLineSpliter( i );
		
		// 最大表示数を超える時は"..."が末尾に来る
		if ( i >= maxCount )
		{
			loginInfoText += "..."
			break;
		}
		
		// ユーザログイン数を部屋ごとに獲得して表示内容に追加する
		// TODO: dataは明示的に定義されたオブジェクトにしたい
		var data : Object = loginUserCountList[i];
		var roomNumber : int = data[0];
		var loginCount : int = data[1];
		
		loginInfoText += "No. " + roomNumber + " ： " + loginCount + " 人";
	}
	
	if( loginInfoText.length == 0 )
	{
		// ログイン情報が何もないなどで表示するべき物が無い場合は
		// 誰もログインしていない旨を表示しておく
		loginInfoText = "誰もログインしていません";
	} else
	{
		// そうでない場合は「ログイン状況」を先頭に付与して表示内容の意味を提示する
		loginInfoText = "ログイン状況\n" + loginInfoText;
	}
	
	// 生成した情報テキストをダイアログに表示
	Alert.show( loginInfoText );
}

// 各部屋のログイン数を表示する時
// そのroomIndex部屋目についての区切り文字列を返します
// @param roomIndex 部屋のインデクス
private function getLoginCountLineSpliter( roomIndex : int ) :  String
{
	if( roomIndex == 0 ) return "";
	if( ( roomIndex % showLoginCountPerLine ) == 0 ) return "\n";
	return ", ";
}


private function setMaxPlayRoomNumber( playRoomMaxNumber : int) : void
{
	// TODO:
	/*
	guiInputSender.setPlayRoomMaxNumber(playRoomMaxNumber);
	
	var tabCount:int = (playRoomMaxNumber / playRoomGetRangeMax) + 1;
	for(var i:int = 0 ; i < tabCount ; i++) {
		var box:Box = new Box();
		box.label = "" + (i * playRoomGetRangeMax) + "-";
		playRoomStateTabs.addChild( box );
	}
	*/
}

private function reloadDeletedPlayRoom(deletedRoomNumbers:Array):void {
	if( deletedRoomNumbers == null ) {
		return;
	}
	
	if( deletedRoomNumbers.length > 0 ) {
		//削除したプレイルームのタブを更新。複数タブのプレイルームは選択できない仕様なので先頭の1部屋だけで処理実施。
		var firstDeleteNumber:int = deletedRoomNumbers[0];
		// getPlayRoomStatesByRoomNumber(firstDeleteNumber, true);
	}
}

private function askDeletePlayRoom(askDeleteRoomNumbers:Array):void {
	// Log.logging("askDeleteRoomNumbers", askDeleteRoomNumbers);
	
	if ( askDeleteRoomNumbers == null )
	{
		return;
	}
	
	for each( var i : int in askDeleteRoomNumbers )
	{
		this.askDeleteWhenUserExist( i );
	}
}

private function askDeleteWhenUserExist( roomNumber : int ) : void
{
	var message:String = "No."+ roomNumber + "にログインしているユーザーがまだいるようです。\n削除してよいですか？";
	var ignoreLoginUser:Boolean = true;
	removePlayRoomWithMessage([roomNumber], message, ignoreLoginUser);
}


private function inputPaswordToDeletePlayRoom( passwordRoomNumbers : Array ) : void
{
	if ( passwordRoomNumbers == null )
	{
		return;
	}
	
	for each( var roomNumber : int in passwordRoomNumbers )
	{
		inputPaswordToDeleteTargetRoom(roomNumber);
	}
}

private function inputPaswordToDeleteTargetRoom( roomNumber : int ) : void
{
	/*
	var window : InputTextWindow = DodontoF.popup( InputTextWindow, true ) as InputTextWindow;
	
	var texts:Array = ["部屋 [ No." + roomNumber + " ] を削除します。パスワードを入力してください。"];
	var ignoreLoginUser:Boolean = true;
	
	window.init(
		texts, "部屋削除", "パスワード入力",
		function(password:String):void
		{
			guiInputSender.removePlayRoom([roomNumber], removePlayRoomResult, ignoreLoginUser, password);
		}
	);
	*/
}


private function printErrorMessageForDeletePlayRom( errorMessages : Array ) : void
{
	/*
	if ( errorMessages == null )
	{
		return;
	}
	
	var errorMessage:String = ""
	for each(var s:String in errorMessages)
	{
		errorMessage += Messages.getMessage(s);
	}
	
	if ( errorMessage.length > 0 )
	{
		Alert.show(errorMessage);
	}
	*/
}



private function login( roomNumber : int ) : void
{
	/*
	try
	{
		enableLoginButton(false);
		var adminPasswordText:String = ( adminPassword.enabled ? adminPassword.text : null );
		guiInputSender.checkRoomStatus( roomNumber, adminPasswordText, checkRoomStatusResult );
	} catch (error:Error)
	{
		status = error.message;
		enableLoginButton();
	}
	*/
}

private function getEnterPlayRoomFunction(
	roomNumber:int,
	roomName:String,
	chatChannelNames:Array
) : Function
{
	// TODO:
	/*
	var enterPlayRoomFunction:Function =
		function(password:String = "", visiterMode:Boolean = false):void
		{	
			Log.logging("enterPlayRoomFunction begin");
			
			var startFlag:Boolean = ( roomNumber != -1 );
			Log.logging("startFlag", startFlag);
			
			if( startFlag )
			{
				checkTotalLoginCount();
			}
			
			guiInputSender.setSaveDataDirIndex(roomNumber);
			
			Log.logging("LoginWindow, getEnterPlayRoomFunction setPlayRoomPassword", password);
			DodontoF_Main.getInstance().setPlayRoomPassword(password);
			DodontoF_Main.getInstance().setVisiterMode(visiterMode);
			
			DodontoF_Main.getInstance().start(startFlag);
			
			PopUpManager.removePopUp(this);
			Log.logging("enterPlayRoomFunction end");
		}
	
	return enterPlayRoomFunction;
	*/
	return function( password : String = "", visiterMode : Boolean = false ) : void { };
}

private function checkTotalLoginCount( ) : void
{	
	/*
	if ( totalLoginCountLimit <= 0 )
	{
		return;
	}
	
	var key:String = "totalLoginCount";
	var info:Object = Config.getInstance().loadInfo( key );
	if ( info == null )
	{
		info = {
			"count" : 0
		};
	}
	
	if ( info.count > totalLoginCountLimit )
	{
		var window:CheckLoginCountWindow = DodontoF.popupForce(CheckLoginCountWindow, true) as CheckLoginCountWindow;
		window.setMessage(info.count);
	}
	
	info.count++;
	
	Config.getInstance().saveInfo(key, info);
	*/
}

private function setDiceBotInfos( jsonData : Object ) : void
{
	/*
	var diceBotInfos:Array = jsonData.diceBotInfos;
	Log.logging("diceBotInfos", diceBotInfos);
	DodontoF_Main.getInstance().setDiceBotInfos( diceBotInfos );
	*/
}

// TODO: イベント送付のみにして、Modelから実際のリクエストが発行されるようにするべき？
// この事を考えるとDodontoS的にはModelはInterfaceとしてそれぞれのWindowは何のModelに依存するのか分かるようにしつつ、コンストラクションタイミングでModelはViewControllerに与えられるべきだが
// イベント構造による実装を選択したのは失敗か？
// そもそもイベントが一意に世界で共有されているということは
// これは言い換えると１つのクラスが(弱い形で)世界に横たわっていて
// そこにひたすらクエリを投げているのと変わらない
// GlobalなMediatorを導入しているようなものなので
// Modelsクラスがあったらいいだけではないだろうか？
private function onClickCreatePlayRoom( ) : void
{
	enableLoginButton( false );
	DodontoSMediator.getInstance( ).showCreatePlayRoomWindow(
		function( result : Boolean ) : void
		{
			enableLoginButton( true );
		}
	);
}

private function loginByRoomNumber( roomIndex : int ) : void
{
	if ( roomIndex == -1 )
	{
		return;
	}
	
	// ここでURLSに依存するのはおかしい
	var currentUrl : String = URLS.getOwnRawURL();
	var targetUrl : String = currentUrl;
	
	if ( currentUrl.indexOf("loginRoom=") == -1 )
	{
		if ( currentUrl.indexOf("?") == -1)
		{
			targetUrl += "?";
		} else
		{
			targetUrl += "&";
		}
		targetUrl += "loginRoom=" + roomIndex;
	}
	
	// Log.loggingTuning("targetUrl", targetUrl);
	
	var request:URLRequest = new URLRequest( targetUrl );
	navigateToURL( request, "_self" );
}


private function onClickEditReplayData( ) : void
{
	// TOOD: モデルへ
	// DodontoF_Main.getInstance().editReplayData();
}

private function onClickUploadReplayData( ) : void
{
	// TOOD: モデルへ
	// DodontoF.popup(ReplayUploadWindow, true);
}


private function onClickPlayReplayData( replayDataUrl : String = null ) : void
{
	// TOOD: モデルへ
	/*
	stage.frameRate = 60;
	getEnterPlayRoomFunction( -1, "リプレイルーム", null).call( );
	if ( replayDataUrl == null )
	{
		DodontoF_Main.getInstance().replayFromSessionRecord();
	} else
	{
		DodontoF_Main.getInstance().replayFromDataUrl(replayDataUrl);
	}
	*/
}
