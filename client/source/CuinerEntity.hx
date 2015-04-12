package;

/**
 * ...
 * @author 
 */
class CuinerEntity
{
	/**
	 * Reference to the application running.
	 */ 
	public var application(get_application, never):CuinerApplication;
	private function get_application():CuinerApplication { return CuinerApplication.instance; }

	public function new() 
	{
		
	}
	
}