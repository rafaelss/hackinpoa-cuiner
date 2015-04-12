package cnr.view.search;
import cnr.model.CuinerModel;
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
		super();
		
		trace("SearchView> ctor");
		
		var bt : Element;	
		var btl:Array<String> =
		[
		
		];
		for (i in 0...btl.length) 
		{ 
			bt = Browser.document.getElementById(btl[i]); 
			if (bt == null) { trace("[" + btl[i] + "]"); continue; }
			bt.onclick = OnButtonClick;		
		}
		
	}
	
	
	private function OnButtonClick(p_event:Dynamic):Void
	{
		var ev : MouseEvent = p_event;
		var el : Element = cast	ev.currentTarget;
		trace("SearchView> Clicked ["+el.id+"]");
		switch(el.id)
		{
			default: 
				
		}
		
	}
	
}