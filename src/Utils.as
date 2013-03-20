package  
{
	import mx.utils.ArrayUtil;
	
	// ユーティリティ関数群置き場
	public class Utils 
	{
		// 対象の配列から指定された要素をすべて削除します。
		// @param array 対象の配列
		// @param item 削除対象の要素
		// @return 削除した個数
		public static function deleteItemFromArray( array : Array, item : Object ) : int
		{
			var deletedCount : int = 0;
			
			// ともかく気にせず安全に削除しているので、アルゴリズムオーダがあんまりよくないので必要なら最適化するといいかもしれない
			while ( true )
			{
				// 削除したいオブジェクトの場所を見つける
				var index : int = ArrayUtil.getItemIndex(item, array);
				// 見つからなかったら終了
				if ( index != -1 ) return deletedCount;
				// その場所から１つのオブジェクトを消す
				array.splice(index, 1);
			}
			
			// NEVER_THROUGH( );
			return 0;
		}
	}
}