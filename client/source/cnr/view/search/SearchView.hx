package cnr.view.search;
import cnr.model.CuinerModel;
import cnr.view.home.HomeModalView;
import haxe.Timer;
import js.Browser;
import js.html.Element;
import js.html.ImageElement;
import js.html.MouseEvent;

/**
 * ...
 * @author 
 */
class SearchView extends CuinerEntity
{
	
	public var modal : HomeModalView;
	
	
	public function new() 
	{
		super();
		
		trace("SearchView> ctor");
		
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
			"field-menu-user-photo",
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
		
		var search_url : String =  "search.html?";
		
		trace("SearchView> Clicked ["+el.id+"]");
		switch(el.id)
		{
			case "bt-location":
			case "bt-register":
				modal.Show("modal-register");
			case "bt-login":
				modal.Show("modal-login");
			case "bt-search":
				
				search_url += "q=" + modal.SearchData.q;
				if (modal.SearchData.price != "") search_url += "&price=" + modal.SearchData.price;
				if (modal.SearchData.persons != "") search_url += "&persons=" + modal.SearchData.persons;				
				Browser.window.location.href = search_url;
			case "bt-form-register":
				trace(modal.RegisterData);
				application.controller.ProcessRegister(modal.RegisterData,modal);
			case "bt-form-login":
				trace(modal.LoginData);
				application.controller.ProcessLogin(modal.LoginData, modal);
				
			case "field-menu-user-photo": application.controller.LogOut();
				
		}
		
	}
	
}