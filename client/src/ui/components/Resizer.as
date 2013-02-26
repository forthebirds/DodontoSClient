//--*-coding:utf-8-*--

//本ソースコードは以下から流用させていただいております。
//この場を借りてお礼申し上げます
//http://koharubiyori-n.cocolog-nifty.com/blog/2008/05/flex_fd4a.html

package ui.components
{

	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.core.Application;
	import mx.core.UIComponent;
	import mx.events.FlexMouseEvent;
	import mx.managers.CursorManager;
	
	import flash.utils.Dictionary;
	
	// Resizerはモノステートクラスです
	// そのためすべてのインスタンスは状態を共有しています。注意が必要。
	public class Resizer
	{
		private static var mCurrentCursor : Class;	// 現在利用しているカーソル

		[Embed(source="/image/cursor/cur_vertical.png")]
		private static const CONST_CUR_VERTICAL : Class;

		[Embed(source="/image/cursor/cur_horizontal.png")]
		private static const CONST_CUR_HORIZONTAL : Class;

		[Embed(source="/image/cursor/cur_left_oblique.png")]
		private static const CONST_CUR_LEFT_OBLIQUE : Class;

		[Embed(source="/image/cursor/cur_right_oblique.png")]
		private static const CONST_CUR_RIGHT_OBLIQUE : Class;

		// カーソル表示位置の中央X位置。この位置を中心に描画します
		private static function getCursorXCenter( cursor : Class ) : Number
		{
			switch( cursor )
			{
			case CONST_CUR_LEFT_OBLIQUE: return 6;
			case CONST_CUR_RIGHT_OBLIQUE: return 6;
			case CONST_CUR_VERTICAL: return 9;
			case CONST_CUR_HORIZONTAL: return 9;
			default: return 0;
			}
		}
		

		// カーソル表示位置の中央Y位置。この位置を中心に描画します
		private static function getCursorYCenter( cursor : Class ) : Number
		{
			switch( cursor )
			{
			case CONST_CUR_LEFT_OBLIQUE: return 6;
			case CONST_CUR_RIGHT_OBLIQUE: return 6;
			case CONST_CUR_VERTICAL: return 9;
			case CONST_CUR_HORIZONTAL: return 9;
			default: return 0;
			}
		}
        
		private static const CONST_MODE_NONE : uint = 0;
		private static const CONST_MODE_LEFT : uint = 1;
		private static const CONST_MODE_RIGHT : uint = 2;
		private static const CONST_MODE_TOP : uint = 4;
		private static const CONST_MODE_BOTTOM : uint = 8;
		private static const CONST_MODE_MOVE : uint = 11;
		
		private static var mResizeTarget : ResizableWindow;
		private static var mResizeMode : uint = 0;
		private static var mIsResizing : Boolean = false;
		private static var mResizeAreaMargin : Number = 6;

		private static var mResizeRect : Rectangle;		
		private static var mOldRect : Rectangle;
		private static var mOldPoint : Point;
		
		private static var mRubberBand : RubberBand;
        

		// リサイズ対象のResizableWindowをResizerに登録しリサイズを行えるようにします
		// @param target リサイズ可能にする対象のResizableWindow
		// @param minSize リサイズ時、それ以上小さくしない最小サイズ
		public static function addResize( target : ResizableWindow, minSize : Point ) : void
		{
			target.setStyle("resizer_minSize", minSize);
			target.setStyle("resizer_isPopUp", target.isPopUp);
            
			target.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
			target.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			target.addEventListener( MouseEvent.MOUSE_OUT, onMouseOut );
		}
        
		// リサイズ対象から指定されたResizableWindowを取り除きます
		public static function removeResize( target : ResizableWindow ) : void
		{
			target.removeEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
			target.removeEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			target.removeEventListener( MouseEvent.MOUSE_OUT, onMouseOut );
		}
		
		// 現在リサイズ操作中であるか返す
		public static function get isResizing( ) : Boolean
		{
			return mIsResizing;
		}
        
		// ウィンドウの端をリサイズ領域としてみなす範囲
		public static function set resizeAreaMargin( value : Number ) : void
		{
			mResizeAreaMargin = value;
		}
        
		// ウィンドウの端をリサイズ領域としてみなす範囲
		public static function get resizeAreaMargin( ) : Number
		{
			return mResizeAreaMargin;
		}
        
		private static function onMouseDown( event : MouseEvent ) : void
		{
			if( mResizeMode == CONST_MODE_NONE ) return;
            
            mResizeTarget = ResizableWindow( event.currentTarget );
            mResizeTarget.parent.addEventListener( MouseEvent.MOUSE_UP, onMouseUp );
            mResizeTarget.parent.addEventListener( MouseEvent.MOUSE_MOVE, onResizeRubberBand );
            
            mResizeRect = new Rectangle(
					mResizeTarget.x,
                    mResizeTarget.y,
                    mResizeTarget.width,
                    mResizeTarget.height
				);
            
            mOldRect = mResizeRect.clone( );
            mOldPoint = new Point( mResizeTarget.parent.mouseX, mResizeTarget.parent.mouseY ); 
            if( mRubberBand ) mResizeTarget.parent.removeChild( mRubberBand );
            mRubberBand = new RubberBand();				
            
            mResizeTarget.parent.addChild( mRubberBand );
            mRubberBand.setRect( mResizeRect );
		}
        
		private static function onMouseUp( event : MouseEvent ) : void
		{
			mResizeTarget.parent.removeEventListener( MouseEvent.MOUSE_UP, onMouseUp );
			mResizeTarget.parent.removeEventListener( MouseEvent.MOUSE_MOVE, onResizeRubberBand );
            
			// ターゲットがまだ生きてるならRubberBandからこちらにリサイズ反映
			// (nullになあることは本来無いはずだけど、安全に倒す)
			if( mResizeTarget )
			{
				mResizeTarget.x = mResizeRect.x;
				mResizeTarget.y = mResizeRect.y;
				mResizeTarget.width = mResizeRect.width;
				mResizeTarget.height = mResizeRect.height;
				mResizeTarget.parent.removeChild( mRubberBand );
                
				// リサイズが発生したイベントを通知
				mResizeTarget.resizeEvent( );
			}
			mRubberBand = null;
			mResizeTarget = null;
		}

		private static function filterResizeModeByResizability( target : ResizableWindow, mode : uint ) : uint 
		{
			if( !target.isVerticalResizable( ) )
			{
				// 縦リサイズ不能なら、縦の側のフラグをフィルタする
				mode &= ~CONST_MODE_TOP;
				mode &= ~CONST_MODE_BOTTOM;
			}

			// TODO: 横リサイズ不能なウィンドウも作成可能にしてよいかもしれない。その時は以下をコメントイン。現在は提供しない。
			/*
			if( !target.isHorizontalResizable( ) )
			{
				// 横リサイズ不能なら、横の側のフラグをフィルタする
				mode &= ~CONST_MODE_LEFT;
				mode &= ~CONST_MODE_RIGHT;
			}
			*/

			return mode;
		}

		private static function onMouseMove( event : MouseEvent ) : void
		{
			var target : ResizableWindow = event.currentTarget as ResizableWindow;
			if( target == null ) return;	// ResizableWindowではないなら処理の対象外。そんなことは無いはずだけど。。。

            setCursorOnMouseMove( target );
            setPopUpMode( target );
        }
			
		private static function setCursorOnMouseMove( target : ResizableWindow ) : void
		{
			const point : Point = new Point( target.x, target.y );
			
			// リサイジングであるフラグを立てる(????あれ。ここはまだリサイズ中ではないのではなかろうか)
			mIsResizing = true;
			
			// リサイズターゲットが無い時はもはや動かす物はないので終了
			// TODO: mIsResizing降ろさなくていいの？あるいは、判定の順序が逆では？
			if( mResizeTarget != null ) return;
            
            const posX : Number = target.parent.mouseX;
            const posY : Number = target.parent.mouseY;

			const handlingRight : Boolean = (point.x + target.width - mResizeAreaMargin) <= posX;
			const handlingBottom : Boolean = (point.y + target.height - mResizeAreaMargin) <= posY;

			const handlingLeft : Boolean = posX <= (point.x + mResizeAreaMargin);
            const handlingTop : Boolean = posY <= (point.y + mResizeAreaMargin);
            
			// TODO: この部分はこれでもまだヤバイので色々直す
            if( handlingRight && handlingBottom )
			{
                changeCursor( CONST_CUR_LEFT_OBLIQUE );
                mResizeMode = CONST_MODE_RIGHT | CONST_MODE_BOTTOM;
            } else if( handlingLeft && handlingTop )
			{
                changeCursor( CONST_CUR_LEFT_OBLIQUE );
                mResizeMode = CONST_MODE_LEFT | CONST_MODE_TOP;
            } else if( handlingLeft && handlingBottom )
			{
                changeCursor( CONST_CUR_RIGHT_OBLIQUE );
                mResizeMode = CONST_MODE_LEFT | CONST_MODE_BOTTOM;
            } else if( handlingRight && handlingTop )
			{
                changeCursor( CONST_CUR_RIGHT_OBLIQUE );
                mResizeMode = CONST_MODE_RIGHT | CONST_MODE_TOP;
            } else if( handlingRight )
			{
                changeCursor( CONST_CUR_HORIZONTAL );
                mResizeMode = CONST_MODE_RIGHT;
            } else if( handlingLeft )
			{
                changeCursor( CONST_CUR_HORIZONTAL );
                mResizeMode = CONST_MODE_LEFT;
            } else if( handlingBottom )
			{
                if( target.isVerticalResizable( ) )
				{
                    changeCursor( CONST_CUR_VERTICAL );
                    mResizeMode = CONST_MODE_BOTTOM;
                }
            } else if( handlingTop )
			{
                if( target.isVerticalResizable( ) )
				{
                    changeCursor( CONST_CUR_VERTICAL );
                    mResizeMode = CONST_MODE_TOP;
                }
            } else
			{
                resetCursor();
            }
			
			// 設定不能なリサイズモードにはしない
			mResizeMode = filterResizeModeByResizability( target, mResizeMode );
        }
        
		private static function setPopUpMode( target : ResizableWindow ) : void
		{
            if( target.getStyle( "resizer_isPopUp" ) == null ) return;
            
            target.isPopUp = (mResizeMode == CONST_MODE_NONE);
		}
		
		private static function resetCursor( ) : void
		{
            changeCursor( null );
            mResizeMode = CONST_MODE_NONE;
            mIsResizing = false;
        }
        
		private static function onMouseOut( event : MouseEvent ) : void
		{
			if( !mResizeTarget ) resetCursor();
		}
		
		private static function onResizeRubberBand( event : MouseEvent ) : void
		{
			// ターゲットがないならresizeする物は何もない
			if( mResizeTarget == null ) return;

			// -------------- 各座標を引き出しておく
			
			// 現在のマウス位置を使ったリサイズ後のサイズ
			var sizeX : Number = mResizeTarget.parent.mouseX - mOldPoint.x;
			var sizeY : Number = mResizeTarget.parent.mouseY - mOldPoint.y;
			
			// リサイズ最小サイズ限界
			var minSize : Point = Point( mResizeTarget.getStyle("resizer_minSize") );

			// -------------- リサイズモードごとに結果の取得を行なう。複数が同時に立つ事がある点に注意

			// 左
			if( mResizeMode & CONST_MODE_LEFT )
			{
				mResizeRect.width = Math.max( mOldRect.width - sizeX, minSize.x );
				mResizeRect.x = mOldRect.x + mOldRect.width - mResizeRect.width;
			}

			// 右
			if( mResizeMode & CONST_MODE_RIGHT )
			{
				mResizeRect.width = Math.max( mOldRect.width + sizeX, minSize.x );
			}

			// 上
			if( mResizeMode & CONST_MODE_TOP )
			{
				mResizeRect.height = Math.max( mOldRect.height - sizeY, minSize.y );
				mResizeRect.y = mOldRect.y + mOldRect.height - mResizeRect.height;
			}

			// 下
			if( mResizeMode & CONST_MODE_BOTTOM )
			{
				mResizeRect.height = Math.max( mOldRect.height + sizeY, minSize.y );
			}

			// -------------- RubberBandに反映する
			mRubberBand.setRect( mResizeRect );

			// -------------- FPSに関係なくマウスに追従したいのでupdateAfterEventで再描画を促す
			event.updateAfterEvent( );
		}

		private static function changeCursor( cursorClass : Class ) : void
		{
			// カーソルが現在のカーソルと変わっていないなら何もしない
			if( mCurrentCursor == cursorClass ) return;

			// カーソルのオフセット値を求めておく
			var offX : Number = -getCursorXCenter( cursorClass );
			var offY : Number = -getCursorYCenter( cursorClass );

			// 現在のカーソルを一旦カーソルマネージャから取り除く
			// TODO: currentCursorIDを消す？mCurrentCursorを消すべきでは？
            CursorManager.removeCursor( CursorManager.currentCursorID );
			// カーソルクラスがnull以外で指定されているなら設定する
			// nullの場合はカーソルをリセットするので特に何もしない
            if( cursorClass ) CursorManager.setCursor( cursorClass, 2, offX, offY );

			// カレントのカーソルは何なのかを保存しておく
            mCurrentCursor = cursorClass;
		}
	}
}	// package ui.components
