package cnr.view.home;
import haxe.Timer;
import js.Browser;
import js.html.Element;
import js.html.InputElement;

/**
 * ...
 * @author 
 */
class HomeModalView extends CuinerEntity
{
	
	
	public var element : Element;
	
	public var RegisterData(get_RegisterData, never):Dynamic;
	private function get_RegisterData():Dynamic	
	{
		var res : Dynamic = { };
		var f : InputElement;		
		f = cast Browser.document.getElementById("field-register-name"); 	 res.name = f.value;
		f = cast Browser.document.getElementById("field-register-phone");    if(f!=null) res.phone = f.value;
		f = cast Browser.document.getElementById("field-register-email"); 	 res.email = f.value;
		f = cast Browser.document.getElementById("field-register-password"); res.password = res.password_confirmation = f.value;		
		return res;
	}
	
	public var LoginData(get_LoginData, never):Dynamic;
	private function get_LoginData():Dynamic	
	{
		var res : Dynamic = { };
		var f : InputElement;		
		f = cast Browser.document.getElementById("field-login-email"); res.email = f.value;
		f = cast Browser.document.getElementById("field-login-password"); res.password = f.value;		
		return res;
	}

	public function new() 
	{
		super();
		element = Browser.document.getElementById("modal");
		var bkg : Element = cast element.children[0];
		bkg.onclick =
		function(ev:Dynamic):Void
		{
			trace("HomeModalView> Background Click");
			Hide();
		};
	}
	
	public function Show(p_mode:String):Void
	{
		
		element.style.display = "block";
		Timer.delay(function() { element.style.opacity = "1.0"; }, 100);
		
		Browser.document.getElementById("modal-login").style.display = p_mode == "modal-login" ? "block" : "none";
		Browser.document.getElementById("modal-register").style.display = p_mode == "modal-register" ? "block" : "none";
		
		
	}
	
	public function Hide():Void
	{
		element.style.opacity = "0.0";
		Timer.delay(function() { element.style.display = "none"; }, 402);
	}
	
	
	/**
	 * 
	 * @param	p_msg
	 */
	public function SetLoginError(p_msg:String):Void
	{
		var el : Element = Browser.document.getElementById("lb-login-error");
		el.innerHTML = p_msg;
	}
	
	/**
	 * 
	 * @param	p_msg
	 */
	public function SetRegisterError(p_msg:String):Void
	{
		var el : Element = Browser.document.getElementById("lb-register-error");
		el.innerHTML = p_msg;
	}
	
}