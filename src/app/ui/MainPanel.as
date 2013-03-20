//--*-coding:utf-8-*--
package app.ui
{
	import mx.core.UIComponent;
    import mx.core.IFlexDisplayObject;
    import mx.managers.PopUpManager;

	public class MainPanel extends UIComponent
	{
		// $B%a%$%s%Q%M%kFb$K%]%C%W%"%C%W%&%#%s%I%&$rI=<($7$^$9(B
		// $BLa$jCM$O;XDj$5$l$?%/%i%9$G$"$k$3$H$,J]>Z$5$l$k$N$G(B
		// $B%-%c%9%H$7$FMxMQ$7$F$/$@$5$$(B
		public function showPopup( className : Class ) : IFlexDisplayObject
		{
			return PopUpManager.createPopUp( this, className, false );
		}

		// $B%a%$%s%Q%M%k$NCf$G%b!<%@%k$J%&%#%s%I%&$rI=<($7$^$9(B
		// $BLa$jCM$O;XDj$5$l$?%/%i%9$G$"$k$3$H$,J]>Z$5$l$k$N$G(B
		// $B%-%c%9%H$7$FMxMQ$7$F$/$@$5$$(B
		public function showModal( className : Class ) : IFlexDisplayObject
		{
			return PopUpManager.createPopUp( this, className, true );
		}
	}    
}	// package src.ui

