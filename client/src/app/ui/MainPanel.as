//--*-coding:utf-8-*--
package app.ui
{
	import mx.core.UIComponent;
    import mx.core.IFlexDisplayObject;
    import mx.managers.PopUpManager;

	public class MainPanel extends UIComponent
	{
		public function popup( className : Class ) : void
		{
			PopUpManager.createPopUp( this, className, false );
		}
	}    
}	// package src.ui

