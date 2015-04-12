package cnr.view;
import cnr.model.CuinerModel;
import cnr.view.home.HomeView;
import js.Browser;
import js.html.Element;

/**
 * ...
 * @author 
 */
class CuinerView extends CuinerEntity
{
	
	public var home : HomeView;

	public function new() 
	{
		super();
		trace("CuinerView> ctor page["+CuinerModel.Page+"]");
	
		switch(CuinerModel.Page)
		{
			case "home": home = new HomeView();
		}
		
		
	}
	
}