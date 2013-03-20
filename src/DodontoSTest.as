package  
{
	import org.flexunit.runner.FlexUnitCore;
	import org.flexunit.listeners.CIListener;
	
	import app.model.PlayerTest;
	import app.model.PlayRoomTest;
	import app.model.SessionTest;
	
	import app.ui.LoginWindowTest;
	
	// DodontoSにおけるすべてのテストを駆動するためのクラス。Monostate
	public class DodontoSTest
	{
		
		// 通常のテストを登録する関数です
		// @see runApplicationTest
		public static function runNormalTests( ) : void
		{
			var flexunit : FlexUnitCore = createFlexUnitCore( );
			
			flexunit.run( PlayerTest );
			flexunit.run( PlayRoomTest );
			flexunit.run( SessionTest );
			
			flexunit.run( LoginWindowTest );
		}
		
		// 各種のグローバルインスタンス群に依存して初めて動くことができるクラスがあります
		//　彼らのための下地をDodontoSMediatorが整えた後に走ってほしいテストはこちらに登録します
		public static function runApplicationTests( ) : void
		{
			var flexunit : FlexUnitCore = createFlexUnitCore( );
		}
		
		// FlexUnitCoreに必要なリスナ類を追加して生成
		private static function createFlexUnitCore( ) : FlexUnitCore 
		{
			var flexUnit : FlexUnitCore = new FlexUnitCore( );
			flexUnit.addListener( new ResultsPanelListener() );

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