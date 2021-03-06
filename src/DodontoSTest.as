package  
{
	import app.GlobalEventSelectorTest;
	import org.flexunit.flexui.TestRunnerBase;
	import org.flexunit.listeners.UIListener;
	import org.flexunit.runner.FlexUnitCore;
	import org.flexunit.listeners.CIListener;
	
	import app.model.PlayerTest;
	import app.model.PlayRoomTest;
	import app.model.SessionTest;
	
	import app.ui.MainPanelTest;
	import app.ui.LoginWindowTest;
	import app.ui.LogWindowTest;

	import app.ConfigTest;
	import app.GlobalEventSelectorTest;
	import app.URLSTest;
	import app.WindowSaveDataTest;
	
	import network.NetworkTest;
	
	import network.restful.RESTLoaderTest;
	import network.restful.RESTRequestTest;
	
	import network.send.JoinRoomSendMessageTest;
	import network.send.RoomStatusSendMessageTest;
	
	import network.receive.LoginReceiveMessageTest;
	import network.receive.RoomStatusReceiveMessageTest;
	
	import network.protocol.CometProtocolTest;
	import network.protocol.HTTPPollingProtocolTest;
	import network.protocol.RTMFPProtocolTest;
	import network.protocol.WebAPIProtocolTest;
	
	import network.strategy.NullNetworkStrategyTest;
	import network.strategy.HTTPPollingNetworkStrategyTest;
	
	import ui.UIUtilsTest;
	
	import ui.components.ResizableWindowTest;
	import ui.components.ResizerTest;
	import ui.components.RubberBandTest;
	
	// DodontoSにおけるすべてのテストを駆動するためのクラス。Monostate
	public class DodontoSTest
	{
		
		// 通常のテストを登録する関数です
		// @see runApplicationTest
		public static function runNormalTests( testRunner : TestRunnerBase ) : void
		{
			var flexunit : FlexUnitCore = createFlexUnitCore( testRunner );
			
			flexunit.run(
				PlayerTest,
				PlayRoomTest,
				SessionTest,
			
				LogWindowTest,
				MainPanelTest,
				LoginWindowTest,

				ConfigTest,
				GlobalEventSelectorTest,
				URLSTest,
				WindowSaveDataTest,

				NetworkTest,
				
				RESTLoaderTest,
				RESTRequestTest,

				LoginReceiveMessageTest,
				RoomStatusReceiveMessageTest,

				JoinRoomSendMessageTest,
				RoomStatusSendMessageTest,

				CometProtocolTest,
				HTTPPollingProtocolTest,
				RTMFPProtocolTest,
				WebAPIProtocolTest,

				NullNetworkStrategyTest,
				HTTPPollingNetworkStrategyTest,

				UIUtilsTest,

				ResizableWindowTest,
				ResizerTest,
				RubberBandTest,

				UtilsTest
			);
		}
		
		
		// 各種のグローバルインスタンス群に依存して初めて動くことができるクラスがあります
		//　彼らのための下地をDodontoSMediatorが整えた後に走ってほしいテストはこちらに登録します
		public static function runApplicationTests( ) : void
		{
			// ApplicationレベルのテストではGUIを使うのは難しいと思われる
			var flexunit : FlexUnitCore = createFlexUnitCore( null );
		}
		
		// FlexUnitCoreに必要なリスナ類を追加して生成
		// @param testRunner テストをGUIで表示するためのTestRunnerBase。nullでGUI表示を行わない
		private static function createFlexUnitCore( testRunner : TestRunnerBase ) : FlexUnitCore 
		{
			var flexUnit : FlexUnitCore = new FlexUnitCore( );
			flexUnit.addListener( new ResultsPanelListener() );
			if( testRunner != null )
				flexUnit.addListener( new UIListener( testRunner ) );

			return flexUnit;
		}
	}

}


// 結果をFlashDevelopのResultsパネルに表示するためのリスナ
// http://d.hatena.ne.jp/ActionScript/20100328/fd_flex_unit_4_results_panel を参考にしました。ありがとうございます。
import org.flexunit.runner.notification.Failure;
import org.flexunit.runner.notification.RunListener;

class ResultsPanelListener extends RunListener	// まあせっかくRunListener準備してくれてるし。。。
{	
	public override function testFailure( failure : Failure ) : void 
	{	
		var stackTrace : String = failure.stackTrace;
		var pattern : RegExp = /\[[^)]+\]/g;
		var result : Object = pattern.exec(stackTrace);
		while (result != null)
		{
			var array : Array = result[0].replace("[", "").replace("]","").split(":");
			trace(array[0] + ":" + array[1] + "(" + array[2] + "): [WARN] " + failure.message);
			result = pattern.exec(stackTrace);
		}
	}
}
