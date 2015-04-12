package cnr.model;
import js.Browser;

/**
 * Class that defines global values and flags.
 * @author 
 */
@:native("CuinerFlags")
class CuinerModel
{

	/**
	 * Is Logged.
	 */
	static public var Logged : Bool = false;
	
	/**
	 * Is Running Locally
	 */
	static public var Local  : Bool = true;
	
	/**
	 * Root URL
	 */
	static public var Root(get_Root,never) : String;
	static function get_Root():String { return Local ? "http://localhost:3000/" : "http://cuiner.herokuapp.com/"; }
	
	/** 
	 * Returns all data after the root url.
	 */
	static public var Path(get_Path, never) : String;
	static function get_Path():String
	{
		var s : String = Browser.window.location.pathname;		
		return s.substr(1);
	}
	
	/** 
	 * Returns the Page based on the current path. 
	 */
	static public var Page(get_Page, never) : String;
	static function get_Page():String
	{
		var p : String = Path.toLowerCase();
		
		if (p == "") return "home";
		if (p.indexOf("dashboard/user") >= 0) return "register-user";
		if (p.indexOf("dashboard/menu") >= 0) return "register-menu";
		return "";		
	}
	
}