package;
import cnr.controller.CuinerController;
import cnr.model.CuinerModel;
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
		untyped if (window.Model == null) window.Model = cnr.model.CuinerModel;		
		untyped if (window.WS == null) window.WS = cnr.model.CuinerWS;
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
		
		var ref : Dynamic;
		ref = controller;
		untyped if (window.Controller == null) window.Controller = ref;
	}
}