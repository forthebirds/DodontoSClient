package app 
{
	import flash.events.Event;
	
	// このファイル名は何とかならないかなあ。
	// アプリケーション全体で一貫して用いるイベント定数類がここに定義されているという話なんだけど……。
	
	// DodontoF全体で用いるイベント定数の列挙。
	// このイベント定数定義はアプリケーションとして意味のあるものを使う
	// TODO: このイベント値は余り考察された適切なイベントではなく、ひたすらビューからイベントを追いだした結果であるため、体系化されていない。体系化し管理方式を洗練させるべき。
	public class Events
	{		
		// セーブするようにリクエストされている
		public static const REQ_SAVE : String = "req_save";
		// セーブされた
		public static const ON_SAVED : String = "save";
		
		// ロードするようにリクエストされている
		public static const REQ_LOAD : String = "req_load";
		// ロードされた
		public static const ON_LOADED : String = "load";
		
		// 全データセーブするようにリクエストされている
		public static const REQ_SAVE_ALL : String = "req_save_all";
		// 全データセーブを行った
		public static const ON_SAVE_ALL : String = "save_all";
		
		// 全データロードするようにリクエストされている
		public static const REQ_LOAD_ALL : String = "req_load_all";
		// 全データロードを行った
		public static const ON_LOAD_ALL : String = "load_all";
		
		// チャットログをセーブするようにリクエストされている
		public static const REQ_SAVE_CHAT_LOG : String = "req_save_chat_log";
		// チャットログをセーブした
		public static const ON_SAVE_CHAT_LOG : String = "save_chat_log";
		
		// セッションの録画を開始するようにリクエストされている
		public static const REQ_START_SESSION_RECORDING : String = "req_start_session_recording";
		// セッションの録画を開始した
		public static const ON_START_SESSION_RECORDING : String = "start_session_recording";
		
		// セッションの録画を停止するようにリクエストされている
		public static const REQ_STOP_SESSION_RECORDING : String = "req_stop_session_recording";
		// セッションの録画を停止した
		public static const ON_STOP_SESSION_RECORDING : String = "stop_session_recording";
		
		// ログアウト操作を行うようにリクエストされている
		public static const REQ_LOGOUT : String = "req_logout";
		// ログアウト操作を行った
		public static const ON_LOGOUT : String = "logout";
		
		// TODO: このイベントは「表示」と「非表示」を分離する
		// カードピックアップウィンドウの表示・非表示を設定するようにリクエストされている
		public static const REQ_SET_CARDS_PICKUP_VISIBILITY : String = "req_set_cards_pickup_visibility";
		// カードピックアップウィンドウの表示・非表示を変更した
		public static const ON_SET_CARDS_PICKUP_VISIBILITY : String = "on_set_cards_pickup_visibility";
		
		// カード配置の初期化を行うようにリクエストされている
		public static const REQ_INIT_CARDS_POSTURE : String = "req_init_cards_posture";
		// カード配置の初期化を行った
		public static const ON_INIT_CARDS_POSTURE : String = "init_cards_posture";
		
		// カードの全削除を行うようにリクエストされている
		public static const REQ_CLEAN_CARDS : String = "req_clean_cards";
		// カードの全削除を行った
		public static const ON_CLEAN_CARDS : String = "on_clean_cards";

		// チャットパレットの表示・非表示の設定を行うようにリクエストされている
		public static const REQ_SET_CHAT_PALETTE_VISIBILITY : String = "req_set_chat_palette_visibility";
		// チャットパレットの表示・非表示の設定を行った
		public static const ON_SET_CHAT_PALETTE_VISIBILITY : String = "set_chat_palette_visibility";

		// カウンターリモコンの表示・非表示の設定を行うようにリクエストされている
		public static const REQ_SET_COUNTER_REMOTE_CONTROLLER_VISIBILITY : String = "req_set_counter_remoate_controller_visibility";
		// カウンターリモコンの表示・非表示の設定を行った
		public static const ON_SET_COUNTER_REMOTE_CONTROLLER_VISIBILITY : String = "set_counter_remoate_controller_visibility";

		// チャットウィンドウの表示・非表示の設定を行うようにリクエストされている
		public static const REQ_SET_CHAT_VISIBILITY : String = "req_set_chat_visibility";
		// チャットウィンドウの表示・非表示の設定を行った
		public static const ON_SET_CHAT_VISIBILITY : String = "set_chat_visibility";

		// ダイスの表示・非表示の設定を行うようにリクエストされている
		public static const REQ_SET_DICE_VISIBILITY : String = "req_set_dice_visibility";
		// ダイスの表示・非表示の設定を行った
		public static const ON_SET_DICE_VISIBILITY : String = "set_dice_visibility";

		// イニシアティブの表示・非表示の設定を行うようにリクエストされている
		public static const REQ_SET_INITIATIVE_LIST_VISIBILITY : String = "req_set_initiative_list_visibility";
		// イニシアティブの表示・非表示の設定を行った
		public static const ON_SET_INITIATIVE_LIST_VISIBILITY : String = "set_initiative_list_visibility";

		// 立ち絵の表示・非表示の設定を行うようにリクエストされている
		public static const REQ_SET_STANDING_GRAPHIC_VISIBILITY : String = "req_set_standing_graphic_visibility";
		// 立ち絵の表示・非表示の設定を行った
		public static const ON_SET_STANDING_GRAPHIC_VISIBILITY : String = "set_standing_graphic_visibility";

		// カットインの表示・非表示の設定を行うようにリクエストされている
		public static const REQ_SET_CUTIN_VISIBILITY : String = "req_set_cutin_visibility";
		// カットインの表示・非表示の設定を行った
		public static const ON_SET_CUTIN_VISIBILITY : String = "set_cutin_visibility";

		// 座標の表示・非表示の設定を行うようにリクエストされている
		public static const REQ_SET_POSITION_VISIBILITY : String = "req_set_position_visibility";
		// 座標の表示・非表示の設定を行った
		public static const ON_SET_POSITION_VISIBILITY : String = "set_position_visibility";

		// マス目の表示・非表示の設定を行うようにリクエストされている
		public static const REQ_SET_GRID_VISIBILITY : String = "req_set_grid_visibility";
		// マス目の表示・非表示の設定を行った
		public static const ON_SET_GRID_VISIBILITY : String = "set_grid_visibility";

		// マス目にキャラクタをあわせるか否かの設定を行うようにリクエストされている
		public static const REQ_SET_PIECE_SNAP : String = "req_set_piece_snap";
		// マス目にキャラクタをあわせるか否かの設定を行った
		public static const ON_SET_PIECE_SNAP : String = "set_piece_snap";

		// 立ち絵のサイズを自動調節するか否かの設定を行なうようにリクエストされている
		public static const REQ_SET_AUTO_ADJUST_IMAGE_SIZE : String = "req_set_auto_adjust_image_size";
		// 立ち絵のサイズを自動調節するか否かの設定を行なった
		public static const ON_SET_AUTO_ADJUST_IMAGE_SIZE : String = "set_auto_adjust_image_size";

		// ウィンドウ配置を初期化するようにリクエストされている
		public static const REQ_INIT_WINDOW_STATE : String = "req_init_window_state";
		// ウィンドウ配置を初期化した
		public static const ON_INIT_WINDOW_STATE : String = "init_window_state";

		// ローカルのセーブデータのクリアをリクエストされている
		public static const REQ_INIT_LOCAL_SAVE_DATA : String = "req_init_local_save_data";
		// ローカルのセーブデータをクリアした
		public static const ON_INIT_LOCAL_SAVE_DATA : String = "init_local_save_data";

		// 背景を変更するようにリクエストされている
		public static const REQ_CHANGE_MAP : String = "req_change_map";
		// 背景を変更した
		public static const ON_CHANGE_MAP : String = "change_map";

		// ファイルアップローダを開くようにリクエストされている
		public static const REQ_OPEN_IMAGE_FILE_UPLOADER : String = "req_open_image_file_uploader";
		// ファイルアップローダを開いた
		public static const ON_OPEN_IMAGE_FILE_UPLOADER : String = "open_image_file_uploader";

		// ウェブカメラ撮影アップローダを開くようにリクエストされている
		public static const REQ_OPEN_WEB_CAMERA_CAPTURE_UPLOADER : String = "req_web_camera_capture_uploader";
		// ウェブカメラ撮影アップローダを開いた
		public static const ON_OPEN_WEB_CAMERA_CAPTURE_UPLOADER : String = "web_camera_capture_uploader";

		// 画像のタグを編集するようにリクエストされている
		public static const REQ_EDIT_IMAGE_TAG : String = "req_edit_image_tag";
		// 画像のタグを編集した
		public static const ON_EDIT_IMAGE_TAG : String = "edit_image_tag";

		// 画像を削除するようにリクエストされている
		public static const REQ_DELETE_IMAGE : String = "req_delete_image";
		// 画像を削除した
		public static const ON_DELETE_IMAGE : String = "delete_image";

		// フロアタイルを変更するようにリクエストされている
		public static const REQ_CHANGE_FLOOR_TILE : String = "req_change_floor_tile";
		// フロアタイルを変更した
		public static const ON_CHANGE_FLOOR_TILE : String = "change_floor_tile";

		// マップマスクを追加するようにリクエストされている
		public static const REQ_ADD_MAP_MASK : String = "req_add_map_mask";
		// マップマスクを追加した
		public static const ON_ADD_MAP_MASK : String = "add_map_mask";

		// 簡易マップ作成を行なうようにリクエストされている
		public static const REQ_EASILY_CREATE_MAP : String = "req_easily_create_map";
		// 簡易マップ作成を行なった
		public static const ON_EASILY_CREATE_MAP : String = "easily_create_map";

		// マップ状態保存を行なうようにリクエストされている
		public static const REQ_SAVE_MAP_STATE : String = "req_save_map_state";
		// マップ状態保存を行った
		public static const ON_SAVE_MAP_STATE : String = "save_map_state";

		// マップ切り替えを行なうようにリクエストされている
		public static const REQ_LOAD_MAP_STATE : String = "req_load_map_state";
		// マップ切り替えを行った
		public static const ON_LOAD_MAP_STATE : String = "load_map_state";


		// キャラクタ追加をリクエストされている
		public static const REQ_ADD_CHARACTER : String = "req_add_character";
		// キャラクタ追加を行った
		public static const ON_ADD_CHARACTER : String = "add_character";

		// D&D3版の魔法範囲追加をリクエストされている
		public static const REQ_ADD_MAGIC_RANGE : String = "req_add_magic_range";
		// D&D3版の魔法範囲追加を行った
		public static const ON_ADD_MAGIC_RANGE : String = "add_magic_range";

		// D&D4版の魔法範囲追加をリクエストされている
		public static const REQ_ADD_MAGIC_RANGE_DD4TH : String = "req_add_magic_range_dd4th";
		// D&D4版の魔法範囲追加を行った
		public static const ON_ADD_MAGIC_RANGE_DD4TH  : String = "add_magic_range_dd4th";

		// 魔法タイマー追加をリクエストされている
		public static const REQ_ADD_MAGIC_TIMER : String = "req_add_magic_timer";
		// 魔法タイマー追加を行った
		public static const ON_ADD_MAGIC_TIMER : String = "add_magic_timer";

		// チット作成をリクエストされている
		public static const REQ_CREATE_CHIT : String = "req_create_chit";
		// チット作成を行った
		public static const ON_CREATE_CHIT : String = "create_chit";

		// 墓場の表示をリクエストされている
		public static const REQ_SHOW_GRAVEYARD : String = "req_show_graveyard";
		// 墓場の表示を行った
		public static const ON_SHOW_GRAVEYARD : String = "show_graveyard";

		// キャラクター待合室の表示をリクエストされている
		public static const REQ_SHOW_CHARACTER_WAITING_ROOM : String = "req_show_character_waiting_room";
		// キャラクター待合室の表示を行った
		public static const ON_SHOW_CHARACTER_WAITING_ROOM : String = "show_character_waiting_room";

		// 回転マーカーの表示・非表示の変更をリクエストされている
		public static const REQ_SET_ROTATE_MARKER_VISIBILITY : String = "req_set_rotate_marker_visibility";
		// 回転マーカーの表示・非表示の変更を行った
		public static const ON_SET_ROTATE_MARKER_VISIBILITY : String = "set_rotate_marker_visibility";

		// バージョン表示を行なうようにリクエストされている
		public static const REQ_SHOW_VERSION : String = "req_show_version";
		// バージョン表示を行った
		public static const ON_SHOW_VERSION : String = "show_version";

		// マニュアル表示を行なうようにリクエストされている
		public static const REQ_SHOW_MANUAL : String = "req_show_manual";
		// マニュアル表示を行った
		public static const ON_SHOW_MANUAL : String = "show_manual";

		// チュートリアル・リプレイデータを再生するようにリクエストされている
		public static const REQ_PLAY_TUTORIAL_REPLAY : String = "req_play_tutorial_replay";
		// チュートリアル・リプレイデータを再生を行った
		// TODO: 多分これはだめだ。少なくともSTART_PLAY_TUTORIAL_REPLAYとEND_PLAY_TUTORIAL_REPLAYに分けるべき
		public static const ON_PLAY_TUTORIAL_REPLAY : String = "play_tutorial_replay";

		// オフィシャルサイトへジャンプするようにリクエストされている
		public static const REQ_JUMP_OFFICIAL_SITE : String = "req_jump_official_site";
		// オフィシャルサイトへジャンプした
		public static const ON_JUMP_OFFICIAL_SITE : String = "jump_official_site";
	}
}
