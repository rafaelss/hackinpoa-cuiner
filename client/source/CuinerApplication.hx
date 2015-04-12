package;
import cnr.controller.CuinerController;
import cnr.view.CuinerView;

/**
 * ...
 * @author 
 */
class CuinerApplication
{
	static public var instance : CuinerApplication;

	public var view : CuinerView;
	
	public var controller : CuinerController;
	
	public function new() 
	{
		instance = this;
		
	}
	
	/**
	 * Starts the app.
	 */
	public function Run():Void
	{
		trace("CuinerApplication> Run");
		view = new CuinerView();
		controller = new CuinerController();
		controller.LoadUserData();
		
	}
}