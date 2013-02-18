[Bindable] private var playRoomStates:ArrayCollection = new ArrayCollection();
[Bindable] private var removeOldPlayRoomLimitDays:Number = 0;
[Bindable] private var menuArray:Array;

import mx.collections.ArrayCollection;
import mx.containers.TitleWindow;
import mx.controls.Alert;
import mx.core.IFlexDisplayObject;
import mx.events.CloseEvent;
import mx.events.DataGridEvent;
import mx.events.ListEvent;
import mx.events.MenuEvent;
import mx.managers.PopUpManager;

// これがここにimportされるのはおかしいので修正を入れていく
import app.Config;
import app.URLS;

private var playRoomGetRangeMax:int = 10;
private var playRoomGetRange:int = 10;
private var maxRoom:int = 0;
private var minRoom:int = 0;

// private var guiInputSender:GuiInputSender;
private var isReplay:Boolean;
private var autoLoginRoom:int = 0;

private var defaultUserName:String = "ななしさん";
private var defaultUserNames:Array = [ defaultUserName ];

private var extendMode:Boolean = false;
private var playRoomStatesList:Object = new Object( );

private var totalLoginCountLimit:int = -1;

private var showLoginLineMax:int = 10;
private var showLoginCountPerLine:int = 1;

private var loginUserCountList:Object;
private var isNeedCreatePassword:Boolean = false;

override protected function setup():void
{
	// setupのオーバライドでは必須
	super.setup( );
	
	// 無効値の定義をしなきゃならないけど
	// この場合は負の値を使うとかよりもhaveAutoLogin()を定めたほうがいいかも
	// あとこのメソッド名はget"Auto"LoginRoom()であるべき
	autoLoginRoom = -1;// TODO: autoLoginRoom = DodontoF_Main.getInstance().getLoginRoom();
	
	if ( autoLoginRoom >= 0 )
	{
		this.visible = false;
		// 表示範囲をオートログイン用の部屋１つだけに絞る
		minRoom = autoLoginRoom;
		maxRoom = autoLoginRoom;
	}
	
	// guiInputSender = DodontoF_Main.getInstance().getGuiInputSender();
	
	// 「リプレイ」という考え方とログインウィンドウが結合するのはおかしい
	/*
	var replayDataUrl:String = URLS.getReplayDataURL( );
	var isReplayer:Boolean = DodontoF_Main.getInstance().isReplayer();
	isReplay = ( (replayDataUrl != null) || isReplayer ) ;

	if ( isReplay )
	{
		this.mainBox.visible = false;
		this.mainBox.height = 0;
		this.infoBox.percentHeight = 100;
		
		if ( isReplay )
		{
			replaySessionRecord(replayDataUrl);
		}
		
		return;
	}
	*/
	
	this.getLoginInfo();
	loadPlayerInfo();
	
	menuArray = getMenu();
	
	if( Config.getInstance( ).getModes( ).isAdminMode() )
	{
		setAdminMode();
	}
}

private function getDefaultName():String {
	// TODO:
	/*
	var index:int = Dice.getRandomNumber(defaultUserNames.length) - 1;
	Log.logging("getDefaultName index", index);
	var name:String = defaultUserNames[index];
	Log.logging("getDefaultName name", name);
	return name;
	*/
	return "";
}

private function getMenu():Array {
	return [
			{label:"ヘルプ", data:"pass",
					children: [
							   {label:"バージョン", data:"version"},
							   {label:"マニュアル", data:"manual"},
							   {label:"チュートリアル動画", data:"tutorialReplay"},
							   {label:"オフィシャルサイトへ", data:"officialSite"}
							   ]
					}
			];
}

private function selectMenu(event:MenuEvent):void {
	// TODO: DodontoF_Main.getInstance().getDodontoF().selectMenu(event);
}

private function setAdminMode() : void
{
	yourNameSpace.width = 0;
	
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
}

private function sendMessageAll( ) : void
{
	// TODO:
	/*
	Log.logging("sendMessageAll Begin");
	try { 
		guiInputSender.sendChatMessageAll(broadCastMessageName.text,
										  broadCastMessageText.text,
										  adminPassword.text);
	} catch (error:Error) {
		Log.loggingException("sendMessageAll", error);
	}
	
	broadCastMessageText.text = "";
	Log.logging("sendMessageAll Begin");
	*/
}

private function clickPlayRoomStateInfo():void {
	var index:int = getSelectedRoomNumber();
	if( index == -1 ) {
		return;
	}
	
	roomNumberInput.text = "" + index;
}

private function rollOverPlayRoomStateInfo(event:ListEvent):void {
	var index:int = event.rowIndex
	
	var loginUsers:Array = playRoomStates[index].loginUsers as Array;
	playRoomStateInfo.toolTip = null;
	playRoomStateInfo.toolTip = "ログインユーザー：" + loginUsers.join("  ");
}

private function savePlayerInfo():void
{
	// TODO:
	/*
	var name:String = yourName.text;
	ChatWindow.savePlayerInfo(name);
	ChatWindow.setDefaultCharacterName(name);
	*/
}

private function loadPlayerInfo():void {
	yourName.text = loadDefaultCharacterName();
	savePlayerInfo();
}

private function loadDefaultCharacterName():String
{
	// TODO:
	/*
	Log.logging("loadDefaultCharacterName Begin");
	var info:Object = ChatWindow.getPlayerInfo();
	if( info == null ) {
		return getDefaultName();
	}
	
	var name:String = info["characterName"];
	if( name == null ) {
		return getDefaultName();
	}
	
	if( name == defaultUserName ) {
		return getDefaultName();
	}
	
	Log.logging("loadDefaultCharacterName name", name);
	return name;
	*/
	return "";
}


private function setDefaultUserNames(names:Array):void {
	if( names.length == 1 ) {
		if( names[0] == defaultUserName ) {
			return;
		}
	}
	
	defaultUserNames = names;
	yourName.text = loadDefaultCharacterName();
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

private function getLoginInfo( ) : void
{
	// TODO:
	/*
	var uniqueId:String = null;
	
	var loginInfo:Object = Config.getInstance().loadLoginInfo();
	if( loginInfo != null ) {
		uniqueId = loginInfo.uid1;
	}
	Log.logging("load local uniqueId", uniqueId);
	guiInputSender.getLoginInfo(this.getLoginInfoResult, uniqueId);
	*/
}

private function getSelectedRoomNumber( ) : int
{
	var index:int = playRoomStateInfo.selectedIndex;
	if(index == -1) {
		return -1;
	}
	
	return getRoomNumberByIndex(index)
}

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

public function extend( ) : void
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

public function getPlayRoomStatesByRoomNumber( roomNumber : int, isForce : Boolean ) : void
{
	var index:int = roomNumber / playRoomGetRangeMax;
	getPlayRoomStatesByIndex(index, isForce);
}

public function getPlayRoomStates( ) : void
{
	var index:int = playRoomStateTabs.selectedIndex;
	getPlayRoomStatesByIndex(index);
}

public function getPlayRoomStatesByIndex( index : int , isForce : Boolean = false ) : void
{
	// TODO:
	/*
	enableLoginButton(false);
	
	if( ! isForce ) {
		if( playRoomStatesList[index] != null ) {
			playRoomStates = playRoomStatesList[index];
			enableLoginButton(true);
			return;
		}
	}
	
	var min:int = index * playRoomGetRangeMax;
	var max:int = min + playRoomGetRangeMax - 1;
	guiInputSender.getPlayRoomStates(min, max, this.getPlayRoomStatesResult);
	*/
}

public function getPlayRoomStatesResult( obj : Object ) : void
{
	// TODO:
	/*
	Log.loggingTuning("=>getPlayRoomStatesResult(event:Event) Begin");
	try {
		var result:Object = SharedDataReceiver.getJsonDataFromResultEvent(obj);
		
		var minRoomNumber:int = result.minRoom as int;
		var index:int = minRoomNumber / playRoomGetRangeMax;
		
		var jsonData:Array = result.playRoomStates as Array;
		for each(var data:Object in jsonData ) {
				data.loginUserCount = data.loginUsers.length;
				data.passwordLockState = (data.passwordLockState ? "有り" : "--");
				data.canVisit = (data.canVisit ? "可" : "--");
				data.gameName = DodontoF_Main.getInstance().getDiceBotName(data.gameType);
			}
		playRoomStates = new ArrayCollection(jsonData);
		
		playRoomStatesList[index] = playRoomStates;
	} catch(e:Error) {
		Log.loggingException("getPlayRoomStatesResult", e);
	}
	Log.loggingTuning("=>getPlayRoomStatesResult(event:Event) End");
	enableLoginButton();
	*/
}

public function getLoginInfoResult(obj:Object):void
{
	// TODO:
	/*
	Log.loggingTuning("=>getLoginInfoResult(event:Event) Begin");
	try
	{
		var jsonData:Object = SharedDataReceiver.getJsonDataFromResultEvent(obj);
		Log.logging("getLoginInfoResult jsonData", jsonData);
		
		var checkResult:Boolean = checkLoginInfoResult(jsonData);
		if( ! checkResult ) {
			return;
		}
		
		setLoginInitialInfo(jsonData);
	} catch (e:Error)
	{
		Log.loggingException("getLoginInfoResult", e);
	}
	
	Log.loggingTuning("=>getLoginInfoResult(event:Event) End");
	*/
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

private function setLoginInitialInfo( jsonData : Object ) : void
{
	// TODO:
	/*
	var canLogin:Boolean = analyzeLoginInfo(jsonData);
	if ( ! canLogin )
	{
		return;
	}
	
	if( jsonData.fps != null ) {
		stage.frameRate = jsonData.fps;
	}
	
	isNeedCreatePassword = jsonData.isNeedCreatePassword 
	Config.getInstance().setImageUploadDirInfo(jsonData.imageUploadDirInfo);
	
	playRoomGetRangeMax = jsonData.playRoomGetRangeMax;
	setMaxPlayRoomNumber(jsonData.playRoomMaxNumber);
	
	if( ! isReplay ) {
		loginMessage.htmlText = jsonData.loginMessage;
	}
	
	InitCardWindow.setCardInfos( jsonData.cardInfos );
	setDiceBotInfos(jsonData);
	
	Log.logging("result jsonData.uniqueId", jsonData.uniqueId);
	saveUniqeId( jsonData.uniqueId );
	DodontoF_Main.getInstance().setUniqueId( jsonData.uniqueId);
	
	DodontoF_Main.getInstance().setLoginTimeLimitSecond( jsonData.loginTimeLimitSecond );
	DodontoF_Main.getInstance().setRefreshTimeout( jsonData.refreshTimeout );
	DodontoF_Main.getInstance().setRefreshInterval( jsonData.refreshInterval );
	DodontoF_Main.getInstance().setCommet( jsonData.isCommet );
	ChangeMapWindow.setMaxWidthHeigth( jsonData.mapMaxWidth, jsonData.mapMaxHeigth );
	
	removeOldPlayRoomLimitDays = jsonData.removeOldPlayRoomLimitDays;
	
	setDefaultUserNames(jsonData.defaultUserNames);
	
	ChatWindow.setTalk(jsonData.canTalk);
	ChatSendData.setRetryCountLimit(jsonData.retryCountLimit);
	
	Config.getInstance().setSkinImageUrl( jsonData.skinImage );
	Utils.setSkin(this);
	
	if( jsonData.isPaformanceMonitor) {
		DodontoF_Main.getInstance().getMap().addPaformanceMonitor();
	}
	
	if( autoLoginRoom >= 0 ) {
		Log.loggingTuning("autoLoginRoom", autoLoginRoom);
		
		login( autoLoginRoom );
		return;
	}
	
	enableLoginButton();
	extendButton.enabled = true;
	
	getPlayRoomStates();
	*/
}

private function analyzeLoginInfo( jsonData : Object ) : Boolean
{
	loginUserCountList = jsonData.loginUserCountList as Array;
	// Log.logging("loginUserCountList", loginUserCountList)
	
	currentAllLoginInfo.label = getLoginCountInfo(jsonData);
	
	return checkLoginCount(jsonData);
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

// このメソッドの所在はログイン状況関連を管理する別人かもね。表示はここだろうけど。
private function checkLoginCount( jsonData : Object ) : Boolean
{
	// Log.logging("jsonData.allLoginCount", jsonData.allLoginCount);
	// Log.logging("jsonData.limitLoginCount", jsonData.limitLoginCount);
	
	var countInfo:String = getLoginCountInfo(jsonData);
	
	if ( isValidLimitLoginCount(jsonData) )
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
	
private function showLoginInfo( ) : void
{
	// Log.logging("showLoginInfo loginUserCountList", loginUserCountList);
	if( loginUserCountList == null )
	{
		return;
	}
	
	var text:String = "";
	var maxCount:int = showLoginLineMax * showLoginCountPerLine;
	
	for( var i : int = 0; i < loginUserCountList.length; i++ )
	{	
		text += getLoginCountLineSpliter(i);
		
		if ( i >= maxCount )
		{
			text += "..."
			break;
		}
		
		var data:Object = loginUserCountList[i];
		var roomNumber:int = data[0];
		var loginCount:int = data[1];
		
		text += "No. " + roomNumber + " ： " + loginCount + " 人";
	}
	
	if ( text.length == 0 )
	{
		text = "誰もログインしていません";
	} else {
		text = "ログイン状況\n" + text;
	}
	
	Alert.show( text );
}

private function getLoginCountLineSpliter(lineCount:int):String {
	if( lineCount == 0 ) {
		return "";
	}
	
	if(( lineCount % showLoginCountPerLine ) == 0) {
		return "\n";
	}
	
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

public function removePlayRoom( ) : void
{
	// TODO:
	/*
	try
	{
		var indexs:Array = playRoomStateInfo.selectedIndices;
		Log.logging("indexs", indexs)
		
		if ( indexs == null )
		{
			return;
		}
		
		if ( indexs.length == 0 )
		{
			return;
		}
		
		var message:String = "";
		var roomNumbers:Array = new Array();
		for each(var index:int in indexs) {
				var roomNumber:int = getRoomNumberByIndex(index);
				guiInputSender.checkRoomNumber( roomNumber );
				
				var roomName:String = getRoomNameByIndex(index);
				message += "No." + roomNumber + "：" + roomName + "\n";
				
				roomNumbers.push(roomNumber);
			}
		
		guiInputSender.checkRoomNumber( roomNumber );
		
		message += "を削除しますか？";
		removePlayRoomWithMessage(roomNumbers, message);
	} catch (error:Error)
	{
		status = error.message;
	}
	*/
}

public function removePlayRoomWithMessage(
	roomNumbers:Array,
	message:String,
	ignoreLoginUser:Boolean = false,
	password:String = ""
) : void
{
	// TODO:
	/*
	try{
		var result:Alert = Alert.show(message, "削除確認", 
									  Alert.OK | Alert.CANCEL, null, 
									  function(e : CloseEvent) : void { if (e.detail == Alert.OK) {
											  guiInputSender.removePlayRoom(roomNumbers, removePlayRoomResult,
																			ignoreLoginUser, password);
										  }});
	} catch(error:Error) {
		status = error.message;
	}
	*/
}

public function removePlayRoomResult( event : Event ) : void
{
	// TODO:
	/*
	try
	{
		var jsonData:Object = SharedDataReceiver.getJsonDataFromResultEvent(event);
		
		reloadDeletedPlayRoom(jsonData.deletedRoomNumbers);
		askDeletePlayRoom(jsonData.askDeleteRoomNumbers);
		inputPaswordToDeletePlayRoom(jsonData.passwordRoomNumbers);
		printErrorMessageForDeletePlayRom(jsonData.errorMessages);
		
	} catch(error:Error) {
		status = error.message;
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
		getPlayRoomStatesByRoomNumber(firstDeleteNumber, true);
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


public function removeOldPlayRoom():void {
	/*
	Utils.askByAlert("
		一括削除確認",
		""+ removeOldPlayRoomLimitDays + "日以上前の、古いプレイルームの一括削除を行います。\nよろしいですか？",
		function():void {
			guiInputSender.removeOldPlayRoom(
				function(event:Event=null):void {
					playRoomStatesList = new Object();
					getPlayRoomStates();
				}
			);
		}
	);
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



private function enableLoginButton( b : Boolean = true ) : void
{
	loginButton.enabled = b;
	playRoomStateInfo.enabled = b;
	createNewPlayRoomButton.enabled = b;
	removePlayRoomButton.enabled = b;
	playRoomStateTabs.enabled = b;
}

public function checkRoomStatusResult( obj : Object ) : void
{
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

private function setDiceBotInfos( jsonData : Object ) : void
{
	/*
	var diceBotInfos:Array = jsonData.diceBotInfos;
	Log.logging("diceBotInfos", diceBotInfos);
	DodontoF_Main.getInstance().setDiceBotInfos( diceBotInfos );
	*/
}

private function createPlayRoom():void
{
	/*
	enableLoginButton(false);
	
	var createPlayRoomWindow:CreatePlayRoomWindow =
		DodontoF.popup(CreatePlayRoomWindow, true) as CreatePlayRoomWindow;
	createPlayRoomWindow.initParams(
		-1, isNeedCreatePassword,
		function( roomIndex : int ) : void
		{
			//プレイルームを作り終わったらそのルームナンバーへＵＲＬから直接ログイン
			loginByRoomNumber(roomIndex);
		},
		function():void
		{
			enableLoginButton(true);
		}
	);
	*/
}

private function loginByRoomNumber(roomIndex:int):void
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


private function editReplayData( ) : void
{
	// DodontoF_Main.getInstance().editReplayData();
}

private function uploadReplayData( ) : void
{
	// DodontoF.popup(ReplayUploadWindow, true);
}


private function replaySessionRecord( replayDataUrl : String = null ) : void
{
	/*
	stage.frameRate = 60;
	
	getEnterPlayRoomFunction(-1, "リプレイルーム", null).call();

	if ( replayDataUrl == null )
	{
		DodontoF_Main.getInstance().replayFromSessionRecord();
	} else
	{
		DodontoF_Main.getInstance().replayFromDataUrl(replayDataUrl);
	}
	*/
}
