package cnr.controller;
import cnr.core.Web;
import cnr.model.CuinerModel;
import cnr.view.ModalView;
import haxe.Json;
import haxe.Timer;
import js.Browser;
import js.html.Element;
import js.html.ImageElement;

/**
 * ...
 * @author 
 */
class CuinerController extends CuinerEntity
{

	public function new() 
	{
		super();
		
	}
	
	/**
	 * Loads the user data.
	 */
	public function LoadUserData():Void
	{
		trace("CuinerController> LoadUserData ["+CuinerWS.User+"]");
		Web.LoadJSON(CuinerWS.User, OnUserDataLoad);
	}
	
	/**
	 * Callback called after user data is loaded.
	 */
	public function OnUserDataLoad(p_data:Dynamic,p_progress:Float):Void
	{
		if (p_progress >= 1)	
		{
			if (p_data != null)
			{
				trace("CuinerController> LoadUserData Success");				
				CuinerModel.UserLoginData = p_data.user; 
				trace(CuinerModel.UserLoginData);
				ShowLoginData();
			}
			else
			{
				trace("CuinerController> LoadUserData Failed");
				HideLoginData();
			}
			OnUserDataLoaded();
		}
	}
	
	public function OnUserDataLoaded():Void
	{
		switch(CuinerModel.Page)
		{
			case "home":
				
			case "search":				
			trace("CuinerController> UserDataLoaded [" + Browser.window.location.search+"]");
			ProcessSearch(Browser.window.location.search);
			
			case "detail-cardapio":
			
			
		}
	}
	
	/**
	 * 
	 * @param	p_data
	 */
	public function ProcessLogin(p_data:Dynamic,p_modal:ModalView):Void
	{
		p_modal.SetLoginError("");
		Web.Send(CuinerWS.UserLogin, p_data, function(r:String, p:Float)
		{
			if (p >= 1)
			{
				if (r == null)
				{
					trace("CuinerController> Login Error");
					p_modal.SetLoginError("Erro Email ou Senha Errados!");
				}
				else 
				{
					trace("CuinerController> Login Success");
					p_modal.SetLoginError("Sucesso!");
					CuinerModel.UserLoginData = Json.parse(r);
					CuinerModel.UserLoginData = CuinerModel.UserLoginData.user;
					trace(CuinerModel.UserLoginData);
					p_modal.Hide();
					ShowLoginData();
					
				}
			}
		});
	}
	
	/**
	 * 
	 * @param	p_data
	 */
	public function ProcessRegister(p_data:Dynamic,p_modal:ModalView):Void
	{
		application.view.modal.SetRegisterError("");
		Web.Send(CuinerWS.UserRegister, p_data, function(r:String, p:Float)
		{
			if (p >= 1)
			{
				if (r == null)
				{
					trace("CuinerController> Register Error");
					p_modal.SetRegisterError("Erro no Registro!");
				}
				else 
				{
					trace("CuinerController> Register Success");
					p_modal.SetRegisterError("Sucesso!");
					CuinerModel.UserLoginData = Json.parse(r);
					CuinerModel.UserLoginData = CuinerModel.UserLoginData.user;
					trace(CuinerModel.UserLoginData);
					p_modal.Hide();
					ShowLoginData();
					
				}
			}
		});
	}
	
	/**
	 * 
	 * @param	p_data
	 */
	public function ProcessSearch(p_data:String):Void
	{
		var url : String = CuinerWS.Search+p_data;
		
		trace("CuinerController> search[" + url + "]");
		
		Web.Send(url, p_data, function(r:String, p:Float)
		{
			if (p >= 1)
			{
				if (r == null)
				{
					trace("CuinerController> Search Error");
					
				}
				else 
				{
					trace("CuinerController> Search Success");
					trace(r);
					var res : Dynamic = { menus:[] };
					try
					{
						res = Json.parse(r);
					}
					catch (err:Dynamic) { }
					
					trace(res);
										
				}
			}
		},"GET");
	}
	
	/**
	 * Logout 
	 */
	public function LogOut():Void
	{
		
		Web.Send(CuinerWS.UserLogout, null, function(r:String, p:Float)
		{
			
			
			if (p >= 1)
			{
				CuinerModel.UserLoginData = null; 
				
				if (r == null)
				{
					trace("CuinerController> Logout Error");					
				}
				else 
				{
					trace("CuinerController> Logout Success");					
					trace(r);
					HideLoginData();
				}
			}
		});
	}
	
	/**
	 * 
	 */
	public function ShowLoginData():Void
	{
		var el0 : Element;
		var el1 : Element;
		
		el0 = Browser.document.getElementById("menu-login");
		if (el0 != null)
		{
			el0.style.display = "block";
			Timer.delay(function() { el0.style.opacity = "1.0"; }, 10);
		}
		
		el1 = Browser.document.getElementById("menu-logout");
		if (el1 != null)
		{
			el1.style.opacity = "0.0";
			Timer.delay(function() { el1.style.display = "none";  }, 202);
		}
		
		var user_name : Element = Browser.document.getElementById("field-menu-user-name");
		var user_photo : ImageElement = cast Browser.document.getElementById("field-menu-user-photo");
		if(user_name!=null) user_name.innerText = CuinerModel.UserLoginData.name;
		if(user_photo!=null)user_photo.src = CuinerModel.UserLoginData.photo_url;
	}
	
	/**
	 * 
	 */
	public function HideLoginData():Void
	{
		var el0 : Element;
		var el1 : Element;
		
		el0 = Browser.document.getElementById("menu-logout");
		if (el0 != null)
		{
			el0.style.display = "block";
			Timer.delay(function() { el0.style.opacity = "1.0"; }, 10);
		}
		
		el1 = Browser.document.getElementById("menu-login");
		if (el1 != null)
		{
			el1.style.opacity = "0.0";
			Timer.delay(function() { el1.style.display = "none";  }, 202);
		}
	}
	
	/**
	 * 
	 * @param	p_type
	 */
	public function ProcessClicks(p_type : String):Void
	{
		var search_url : String =  "busca.html?";		
		var mv : ModalView = application.view.modal;
		
		
		switch(p_type)
		{
			case "bt-location":
			case "bt-register":
				mv.Show("modal-register");
			case "bt-login":
				mv.Show("modal-login");
			case "bt-search":
				
				search_url += "q=" + mv.SearchData.q;
				if (mv.SearchData.price != "") search_url += "&price=" + mv.SearchData.price;
				if (mv.SearchData.persons != "") search_url += "&persons=" + mv.SearchData.persons;				
				Browser.window.location.href = search_url;
			case "bt-form-register":
				trace(mv.RegisterData);
				application.controller.ProcessRegister(mv.RegisterData,mv);
			case "bt-form-login":
				trace(mv.LoginData);
				application.controller.ProcessLogin(mv.LoginData, mv);
				
			case "field-menu-user-photo": application.controller.LogOut();
			
			case "bt-publish-bottom",
			     "bt-publish":
					 Browser.window.location.href = CuinerModel.Root + "/dashboard-cardapio.html";
					 
			case "bt-buy-product":
				mv.Show("modal-shop-alert");
				
			case "bt-shop-ok":
				mv.Hide();
				Timer.delay(function() { Browser.window.location.href = CuinerModel.Root; }, 200);
				
			case "bt-cardapio-add":
				Browser.window.location.href = CuinerModel.Root;
				
		}
	}
	
	
}