package;

import cnr.core.Web;
import cnr.model.CuinerModel;
import js.JQuery;

/**
 * ...
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
class Main
{
	
	static function main():Void
	{
		
		CuinerModel.Local = true;
		
		trace("Cuiner> Initialize logged[" + CuinerModel.Logged + "] root[" + CuinerModel.Root + "] path["+CuinerModel.Path+"]");	
		
		Web.LoadJSON("data/mockup-user.json", function(d:Dynamic, p:Float):Void
		{
			if (p >= 1) trace(d);
		});
	}
	
}