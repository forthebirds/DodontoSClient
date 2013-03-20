package app.ui.menu 
{
	import flash.events.Event;
	import app.Events;

	// メインメニューのカテゴリ「表示」を管理するクラス
	public class DisplayMenuCategory implements IMenuCategory
	{
		// Tinyモードか否か。TinyモードではないならばDefaultモードである
		private var mIsTinyMode : Boolean = false;	
		
		public function DisplayMenuCategory() 
		{
				
		}

		private var mSetChatPaletteVisibility : Object =
			{
				label:"チャットパレット表示",
				type:"check",
				toggled:false,
				event: new Event( Events.REQ_SET_CHAT_PALETTE_VISIBILITY )
			};
		private var mSetCounterRemoteControllerVisibility : Object =
			{
				label:"カウンターリモコン表示",
				type:"check",
				toggled:false,
				event: new Event( Events.REQ_SET_COUNTER_REMOTE_CONTROLLER_VISIBILITY )
			};
		private var mSetChatVisibility : Object = 
			{
				label:"チャット表示",
				type:"check",
				toggled:true,
				event: new Event( Events.REQ_SET_CHAT_VISIBILITY )
			};
		private var mSetDiceVisibility : Object =
			{
				label:"ダイス表示",
				type:"check",
				toggled:true,
				event: new Event( Events.REQ_SET_DICE_VISIBILITY )
			};
		private var mSetInitiativeListVisibility : Object =
			{
				label:"イニシアティブ表示",
				type:"check",
				toggled:true,
				event: new Event( Events.REQ_SET_INITIATIVE_LIST_VISIBILITY )
			};
		private var mSetStandingGraphicVisibility : Object =
			{
				label:"立ち絵表示",
				type:"check",
				toggled:true,
				event: new Event( Events.REQ_SET_STANDING_GRAPHIC_VISIBILITY )
			};
		private var mSetCutInVisibility : Object =
			{
				label:"カットイン表示",
				type:"check",
				toggled:true,
				event: new Event( Events.REQ_SET_CUTIN_VISIBILITY )
			};
		private var mSetPositionVisibility : Object =
			{
				label:"座標表示",
				type:"check",
				toggled:true,
				event: new Event( Events.REQ_SET_POSITION_VISIBILITY )
			};
		private var mSetGridVisibility : Object =
			{
				label:"マス目表示",
				type:"check",
				toggled:true,
				event: new Event( Events.REQ_SET_GRID_VISIBILITY )
			};
		private var mSetPieceSnap : Object =
			{
				label:"マス目にキャラクターを合わせる",
				type:"check",
				toggled:true
			};
		private var mSetAutoAdjustImageSize : Object =
			{
				label:"立ち絵のサイズを自動調整する",
				type:"check",
				toggled: true,
				event: new Event( Events.REQ_SET_AUTO_ADJUST_IMAGE_SIZE )
			};
		private var mInitWindowState : Object =
			{
				label:"ウィンドウ配置初期化",
				event: new Event( Events.REQ_INIT_WINDOW_STATE )
			};
		private var mInitLocalSaveData : Object =
			{
				label:"表示状態初期化",
				event: new Event( Events.REQ_INIT_LOCAL_SAVE_DATA )
			};
		private var mChangeMap : Object =
			{
				label:"背景変更",
				event: new Event( Events.REQ_CHANGE_MAP )
			};

		// --------------------------------- IMenuCategory実装
		public function setModeDefault( ) : void
		{
			mIsTinyMode = false;
		}
		
		public function setModeTiny( ) : void
		{
			mIsTinyMode = true;
		}
		
		public function getChildren() : Array
		{
			if ( mIsTinyMode )
			{
				return getTinyModeChildren( );
			} else
			{
				return getDefaultModeChildren( );
			}
		}
		
		private function getDefaultModeChildren( ) : Array
		{
			return [
				mSetChatPaletteVisibility,
				mSetCounterRemoteControllerVisibility,
				{type:"separator"},
				mSetChatVisibility,
				mSetDiceVisibility,
				mSetInitiativeListVisibility,
				{type:"separator"},
				mSetStandingGraphicVisibility,
				mSetCutInVisibility,
				{type:"separator"},
				mSetPositionVisibility,
				mSetGridVisibility,
				{type:"separator"},
				mSetPieceSnap,
				mSetAutoAdjustImageSize,
				{type:"separator"},
				mInitWindowState,
				mInitLocalSaveData
			];
		}
		
		
		private function getTinyModeChildren( ) : Array
		{
			return [
				mSetAutoAdjustImageSize,
				{ type:"separator" },
				mChangeMap
			];
		}
	}
}	// package app.ui.menu

// こういうクラスを作ってイベント発生時の動作管理まで行ったほうが良いかもしれない
// 更に言えばメニューボタンクラス、メニュートグルクラスを作り
// コンストラクタでlabel, toggleまでを受け付けるようにしてれば記述も楽に。
// 抑々event値は状況によって発行したい物変わってくるしなぁ
// onClickedを作ってcallbackをデフォルトにしたほうがいい？
// その上で通常の動作として常に同じREQを送るクラスがあってもいいかもしれないが。
// このアーキの部分には随分コストを掛けている。妥協し、そろそろ決定するべきだ。
/*
class ChatPaletteVisibilityMenuItem
{
	public var label : String = "チャットパレット表示";
	public var type : String = "check";
	public var toggled : Boolean = false;
	public var event : Event = new Event( Events.REQ_SET_CHAT_PALETTE_VISIBILITY );

	public function setVisibility( isVisible : Boolean ) : void
	{
		toggled = isVisible;
	}
}
*/


