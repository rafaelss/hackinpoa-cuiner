package;
import js.Browser;
import js.html.Element;

/**
 * ...
 * @author 
 */
class CuinerEntity
{
	/**
	 * Reference to the application running.
	 */ 
	public var application(get_application, never):CuinerApplication;
	private function get_application():CuinerApplication { return CuinerApplication.instance; }

	public function new(p_mouse_ev:Bool=false) 
	{
		if (p_mouse_ev)
		{
			var bt : Element;	
			var btl:Array<String> =
			[
			"bt-location",
			"bt-register",
			"bt-login",
			"bt-search",
			"bt-form-login",
			"bt-form-register",
			"bt-publish",
			"bt-publish-bottom",
			"bt-category-vegan",
			"bt-category-dessert",
			"bt-category-thai",
			"bt-category-sandwich",
			"bt-category-pizza",
			"bt-category-drinks",	
			"field-menu-user-photo",
			"container-search",
			"bt-buy-product",
			"bt-shop-ok",
			];
			for (i in 0...btl.length) 
			{ 
				bt = Browser.document.getElementById(btl[i]); 
				if (bt == null) { trace(btl[i]);  continue; }
				bt.onclick = OnButtonClick;			
			}
		}
	}
	
	public function OnButtonClick(p_ev:Dynamic):Void { }
	
}