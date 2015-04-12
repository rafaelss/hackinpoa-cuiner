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
		];
		for (i in 0...btl.length) 
		{ 
			bt = Browser.document.getElementById(btl[i]); 
			if (bt == null) { trace("[" + btl[i] + "]"); continue; }
			bt.onclick = OnButtonClick; 
			
		}
		
	}
	
	/**
	 * 
	 */
	public function ShowLoginData():Void
	{
		var el0 : Element;
		var el1 : Element;
		
		el0 = Browser.document.getElementById("menu-login");
		el0.style.display = "block";
		Timer.delay(function() { el0.style.opacity = "1.0"; }, 10);
		
		el1 = Browser.document.getElementById("menu-logout");
		el1.style.opacity = "0.0";
		Timer.delay(function() { el1.style.display = "none";  }, 202);
		
		var user_name : Element = Browser.document.getElementById("field-menu-user-name");
		var user_photo : ImageElement = cast Browser.document.getElementById("field-menu-user-photo");
		user_name.innerText = CuinerModel.UserLoginData.name;
		user_photo.src = "https://hackingintolife.files.wordpress.com/2011/08/thumb-up.gif";
	}
	
	/**
	 * 
	 */
	public function HideLoginData():Void
	{
		var el0 : Element;
		var el1 : Element;
		
		el0 = Browser.document.getElementById("menu-logout");
		el0.style.display = "block";
		Timer.delay(function() { el0.style.opacity = "1.0"; }, 10);
		
		el1 = Browser.document.getElementById("menu-login");
		el1.style.opacity = "0.0";
		Timer.delay(function() { el1.style.display = "none";  }, 202);
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
				application.controller.ProcessRegister(modal.RegisterData);
			case "bt-form-login":
				trace(modal.LoginData);
				application.controller.ProcessLogin(modal.LoginData);
		}
		
	}
	
}