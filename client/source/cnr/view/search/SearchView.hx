package cnr.view.search;
import cnr.model.CuinerModel;
import cnr.view.ModalView;
import haxe.Timer;
import js.Browser;
import js.html.Element;
import js.html.ImageElement;
import js.html.MouseEvent;

/**
 * ...
 * @author 
 */
class SearchView extends CuinerEntity
{
	
	
	
	
	public function new() 
	{
		super(true);
		
		trace("SearchView> ctor");
		
	}
	
	
	override public function OnButtonClick(p_event:Dynamic):Void
	{
		var ev : MouseEvent = p_event;
		var el : Element = cast	ev.currentTarget;
		
		trace("SearchView> Clicked ["+el.id+"]");
		switch(el.id)
		{
			case "container-search":
				el = cast ev.target;
				trace(el.parentElement);
				Browser.window.location.href = "detail-cardapio.html";
		}
		
		application.controller.ProcessClicks(el.id);
		
	}
	
}