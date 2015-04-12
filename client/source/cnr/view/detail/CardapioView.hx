package cnr.view.detail;
import js.html.Element;
import js.html.MouseEvent;

/**
 * ...
 * @author 
 */
class CardapioView extends CuinerEntity
{

	public function new() 
	{
		super(true);
		trace("CardapioView> ctor");
	}
	
	override public function OnButtonClick(p_event:Dynamic):Void
	{
		var ev : MouseEvent = p_event;
		var el : Element = cast	ev.currentTarget;
		
		trace("CardapioView> Clicked ["+el.id+"]");
		switch(el.id)
		{
			default:
				
		}
		
		application.controller.ProcessClicks(el.id);
		
	}
	
}