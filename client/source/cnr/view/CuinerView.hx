package cnr.view;
import cnr.model.CuinerModel;
import cnr.view.detail.CardapioView;
import cnr.view.home.HomeView;
import cnr.view.search.SearchView;
import js.Browser;
import js.html.Element;

/**
 * ...
 * @author 
 */
class CuinerView extends CuinerEntity
{
	
	public var home : HomeView;
	
	public var search : SearchView;
	
	public var detail_cardapio : CardapioView;
	
	public var modal : ModalView;

	public function new() 
	{
		super();
		trace("CuinerView> ctor page[" + CuinerModel.Page+"]");
		
		modal = new ModalView();
	
		switch(CuinerModel.Page)
		{
			case "home": home = new HomeView();
			case "search": search = new SearchView();
			case "detail-cardapio": detail_cardapio = new CardapioView();
		}
		
		
	}
	
}