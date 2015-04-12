package cnr.controller;
import cnr.core.Web;
import cnr.model.CuinerModel;
import haxe.Json;
import haxe.Timer;
import js.Browser;

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
				application.view.home.ShowLoginData();
			}
			else
			{
				trace("CuinerController> LoadUserData Failed");
				application.view.home.HideLoginData();
			}
		}
	}
	
	/**
	 * 
	 * @param	p_data
	 */
	public function ProcessLogin(p_data:Dynamic):Void
	{
		application.view.home.modal.SetLoginError("");
		Web.Send(CuinerWS.UserLogin, p_data, function(r:String, p:Float)
		{
			if (p >= 1)
			{
				if (r == null)
				{
					trace("CuinerController> Login Error");
					application.view.home.modal.SetLoginError("Erro Email ou Senha Errados!");
				}
				else 
				{
					trace("CuinerController> Login Success");
					application.view.home.modal.SetLoginError("Sucesso!");
					CuinerModel.UserLoginData = Json.parse(r);
					CuinerModel.UserLoginData = CuinerModel.UserLoginData.user;
					trace(CuinerModel.UserLoginData);
					application.view.home.modal.Hide();
					application.view.home.ShowLoginData();
					
				}
			}
		});
	}
	
	/**
	 * 
	 * @param	p_data
	 */
	public function ProcessRegister(p_data:Dynamic):Void
	{
		application.view.home.modal.SetRegisterError("");
		Web.Send(CuinerWS.UserRegister, p_data, function(r:String, p:Float)
		{
			if (p >= 1)
			{
				if (r == null)
				{
					trace("CuinerController> Register Error");
					application.view.home.modal.SetRegisterError("Erro no Registro!");
				}
				else 
				{
					trace("CuinerController> Register Success");
					application.view.home.modal.SetRegisterError("Sucesso!");
					CuinerModel.UserLoginData = Json.parse(r);
					CuinerModel.UserLoginData = CuinerModel.UserLoginData.user;
					trace(CuinerModel.UserLoginData);
					application.view.home.modal.Hide();
					application.view.home.ShowLoginData();
					
				}
			}
		});
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
					application.view.home.HideLoginData();
				}
			}
		});
	}
	
	
}