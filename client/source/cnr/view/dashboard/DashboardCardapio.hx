package cnr.view.dashboard;
import js.html.Element;
import js.html.MouseEvent;

/**
 * ...
 * @author 
 */
class DashboardCardapio extends CuinerEntity
{

	public function new() 
	{
		super(true);
	}
	
	override public function OnButtonClick(p_event:Dynamic):Void
	{
		var ev : MouseEvent = p_event;
		var el : Element = cast	ev.currentTarget;
		
		trace("DashboardCardapio> Clicked ["+el.id+"]");
		switch(el.id)
		{
			default:
				
		}
		
		application.controller.ProcessClicks(el.id);
		
	}
	
}