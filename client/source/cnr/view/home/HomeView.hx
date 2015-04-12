package cnr.view.home;
import js.Browser;
import js.html.Element;
import js.html.MouseEvent;

/**
 * ...
 * @author 
 */
class HomeView extends CuinerEntity
{
	
	public var modal : HomeModalView;

	public function new() 
	{
		super();
		
		trace("HomeView> ctor");
		
		modal = new HomeModalView();
		
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
		];
		for (i in 0...btl.length) 
		{ 
			bt = Browser.document.getElementById(btl[i]); 
			if (bt == null) { trace("[" + btl[i] + "]"); continue; }
			bt.onclick = OnButtonClick; 
			
		}
		
	}
	
	private function OnButtonClick(p_event:Dynamic):Void
	{
		var ev : MouseEvent = p_event;
		var el : Element = cast	ev.currentTarget;
		trace("HomeView> Clicked ["+el.id+"]");
		switch(el.id)
		{
			case "bt-location":
			case "bt-register":
				modal.Show("modal-register");
			case "bt-login":
				modal.Show("modal-login");
			case "bt-search":
			case "bt-form-register":
				trace(modal.RegisterData);
			case "bt-form-login":
				trace(modal.LoginData);
				application.controller.ProcessLogin(modal.LoginData);
		}
		
	}
	
}