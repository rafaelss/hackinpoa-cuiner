package cnr.view.home;
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
class HomeView extends CuinerEntity
{
	
	

	public function new() 
	{
		super(true);
		
		trace("HomeView> ctor");
		
		
		
	}
	
	
	
	override public function OnButtonClick(p_event:Dynamic):Void
	{
		var ev : MouseEvent = p_event;
		var el : Element = cast	ev.currentTarget;
		
		var search_url : String =  "busca.html?";
		
		var mv : ModalView = application.view.modal;
		
		trace("HomeView> Clicked ["+el.id+"]");
		switch(el.id)
		{
			case "bt-category-vegan",
			 "bt-category-dessert",
			 "bt-category-thai",
			 "bt-category-sandwich",
			 "bt-category-pizza",
			 "bt-category-drinks":
				
				var cat : String = el.id.split("-")[2];				
				search_url += "q=" + cat;
				Browser.window.location.href = search_url;
			
		}
		
		application.controller.ProcessClicks(el.id);
	}
	
}