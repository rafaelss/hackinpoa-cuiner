package cnr.controller;
import cnr.core.Web;
import cnr.model.CuinerModel;

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
		trace("CuinerController> LoadUserData ["+CuinerWS.UserInit+"]");
		Web.LoadJSON(CuinerWS.UserInit, OnUserDataLoad);
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
				CuinerModel.UserLoginData = p_data; 
			}
			else
			{
				trace("CuinerController> LoadUserData Failed");
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
					application.view.home.modal.SetLoginError("Erro Desconhecido!");
				}
				else 
				{
					trace("CuinerController> Login Success");
					application.view.home.modal.SetLoginError("Sucesso!");
					trace(r);
				}
			}
		});
	}
	
	
}