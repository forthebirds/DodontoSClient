//--*-coding:utf-8-*--

//本ソースコードは以下から流用させていただいております。
//この場を借りてお礼申し上げます
//http://koharubiyori-n.cocolog-nifty.com/blog/2008/05/flex_fd4a.html

package ui.components
{
	import flash.display.Shape;
	import flash.geom.Rectangle;
	
	import mx.core.UIComponent;
	import mx.effects.Tween;

	// ウィンドウ領域のリサイズ時に用いる
	// リサイズサイズをリアルタイムに表示するための青の半透明領域
	public class RubberBand extends UIComponent
	{
		private var m_shape : Shape;
		private var m_first : Boolean = true;
		
		public function RubberBand( )
		{
			super( );
		}
		
		// 与えられたrectの位置・サイズになる
		public function setRect( rect : Rectangle ) : void
		{
			x = rect.x;
			y = rect.y;
			width = rect.width;
			height = rect.height;
		}

		// ------------------------------ UIComponentから継承

		override protected function createChildren( ) : void
		{
			super.createChildren();

			// 自分の子としてシェープを追加して領域表示に用いる
			if( !m_shape )
			{
				m_shape = new Shape( );
				m_shape.alpha = 0;
			    m_shape.graphics.lineStyle( 0, 0x0000FF, 0.2 );
			    m_shape.graphics.beginFill( 0x0000FF, 0.1 );
			    m_shape.graphics.drawRect( 0, 0, 3, 3 );
				m_shape.graphics.endFill( );
				this.addChild( m_shape );
			}	
		}
		
		override protected function updateDisplayList(
			unscaledWidth:Number,
			unscaledHeight:Number
		) : void
		{
			super.updateDisplayList( unscaledWidth, unscaledHeight );
			
			m_shape.width = unscaledWidth;
			m_shape.height = unscaledHeight;
			if( m_first )
			{
				var tween : Tween = new Tween( m_shape, [0], [1], 120 );
				tween.setTweenHandlers( updateTween, endTween );
				m_first = false;
			}
			
		}
		
		// ------------------------------ イベントハンドラ
		private function updateTween( value : Array ) : void
		{
			m_shape.alpha = value[0];
		}
		
		private function endTween( value : Array ) : void
		{
			m_shape.alpha = value[0];
		}
	}
}	// package ui.components
