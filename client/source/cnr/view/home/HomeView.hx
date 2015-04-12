package cnr.view.home;
import cnr.model.CuinerModel;
import haxe.Timer;
import js.Browser;
import js.html.Element;
import js.html.ImageElement;
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
		"bt-category-vegan",
		"bt-category-dessert",
		"bt-category-thai",
		"bt-category-sandwich",
		"bt-category-pizza",
		"bt-category-drinks",	
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
		
		trace("HomeView> Clicked ["+el.id+"]");
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
			
			case "bt-category-vegan",
			 "bt-category-dessert",
			 "bt-category-thai",
			 "bt-category-sandwich",
			 "bt-category-pizza",
			 "bt-category-drinks":
				
				var cat : String = el.id.split("-")[2];				
				search_url += "q=" + cat;
				Browser.window.location.href = search_url;
			
		}
		
	}
	
}