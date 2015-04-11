package cnr.core;
import haxe.Json;
import js.html.ProgressEvent;
import js.html.XMLHttpRequest;
import js.html.XMLHttpRequestProgressEvent;

/**
 * Class that handles loading of data from the net.
 * @author 
 */
class Web
{
	/**
	 * Root url to replace './' by it.
	 */
	static public var Root : String = "";

	
	/**
	 * Loads the text data.
	 * @param	p_url
	 * @param	p_callback
	 */
	static public function Load(p_url:String, p_callback : String->Float->Void):Void
	{
		var url : String = StringTools.replace(p_url, "./", Root);		
		var ld : XMLHttpRequest = new XMLHttpRequest();		
		ld.open("GET", url, true);
		ld.onprogress = 
		function(p_ev:Dynamic):Void
		{
			var ev : XMLHttpRequestProgressEvent = cast p_ev;			
			var bl : Float = cast ev.loaded;
			var bt : Float = cast ev.total;
			var r : Float = bt <= 0.0 ? 0.0 : (0.9999 * (bl / (bt+5)));
			p_callback(null,r);
		};
		ld.onload =
		function(p_ev:Dynamic):Void
		{
			var ev : XMLHttpRequestProgressEvent = cast p_ev;
			p_callback(ld.responseText, 1.0);
		};
		ld.onerror =
		function(p_ev:Dynamic):Void
		{
			p_callback(null, 1.0);
		};		
		ld.send();
	}
	
	/**
	 * Loads data and converts to a JSON object.
	 * @param	p_url
	 * @param	p_callback
	 */
	static public function LoadJSON(p_url:String, p_callback : Dynamic->Float->Void):Void
	{		
		Load(p_url, function(s:String, p:Float):Void { if (s != null) { p_callback(s=="" ? null : Json.parse(s), p); } else p_callback(null, p); } );
	}
	
}