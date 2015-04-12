package;

import cnr.core.Web;
import cnr.model.CuinerModel;
import js.Browser;
import js.JQuery;

/**
 * ...
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
class Main
{
	
	static var app : CuinerApplication;
	
	static function main():Void
	{
		CuinerModel.Local = true;		
		Browser.window.onload = 
		function(ev:Dynamic):Void
		{
			trace("Cuiner> Initialize root[" + CuinerModel.Root + "] path["+CuinerModel.Path+"]");	
			app = new CuinerApplication();		
			app.Run();			
		};
	}
	
}