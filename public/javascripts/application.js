Event.observe(window, 'load', function(){
	
	var nav_html;
	new Ajax.Request('/product/restore_nav',
	{	onSuccess: function(request)
		{
			nav_html = request.responseText;
			if(nav_html != '' && nav_html != null)
			{
				$('left_nav').update(nav_html);
				$('products').addClassName('active');
				$('categories_container').setStyle({display: 'block'})
			}
			else
				new Effect.BlindUp('categories_container', duration = 0)
			
		}
	});
});

function activateProducts()
{

	cacheNav();
	nav('/product/categories')

}

function showCategories()
{
	var pc = $('categories_container');
	
/*	if(pc.visible() == false)
	{
		if($('categories_container').visible() != true)
		{
			if($$('ul#categories li').length == 0)
			{
				new Ajax.Request('/product/categories',{onSuccess: function(request){
					$('categories_container').update(request.responseText);
					new Effect.BlindDown('categories_container', duration = 0.25);
					$('products').addClassName('active');
				}});
			}
			else
			{
				new Effect.BlindDown('categories_container', duration = 0.25);
				$('products').addClassName('active');
			}
		}
	}
	else
	{
		new Effect.BlindUp('categories_container', duration = 0.25);
		$('products').removeClassName('active');
	}
	
	cacheNav();*/
	return false;
}

function hideSubcats()
{
	$$('ul#categories li ul').each(function(element){
		element.setStyle({display: 'none'});
	});
}

function showSubcategories(id)
{
	//shows the available subcategories for a category and provides navigation to the category
	
	var cat = $(id);
	var category_id = id.substring(3);
	var subcat;
	if(cat.hasClassName('active') == false)
	{
		if($(id + '_subcats'))
		{
			subcat = $$('li#' + id + '_subcats ul')[0];
			navToCategory(category_id, subcat);
		}
		else
		{
			new Insertion.After(id, '<li id="' + id + '_subcats"></li>');
			new Ajax.Request('/product/subcategories/' + category_id,{onSuccess: function(request){
				$(id + '_subcats').update(request.responseText);
				subcat = $$('li#' + id + '_subcats ul')[0];
				navToCategory(category_id, subcat);
			}});
		}
	}
	else
	{
		subcat = $$('li#' + id + '_subcats ul')[0];
		navToCategory(category_id, subcat);
	}
}

function showSections(id)
{
	//shows the available sections for a subcategory and provides navigation to the subcategory
	
	var subcat = $(id);
	var subcat_id = id.substring(3);
	var section;
	
	if(subcat.hasClassName('active') == false)
	{
		if($(id + '_sections'))
		{
			section = $$('li#' + id + '_sections ul')[0];
			navToSubcategory(subcat_id,section);
		}
		else
		{
			new Insertion.After(id, '<li id="' + id + '_sections"></li>');
			new Ajax.Request('/product/sections/' + subcat_id,{onSuccess: function(request){
				$(id + '_sections').update(request.responseText);
				section = $$('li#' + id + '_sections ul')[0];
				subcat.addClassName('active');
				navToSubcategory(subcat_id,section);
			}});
		}
	}
	else
	{
		section = $$('li#' + id + '_sections ul')[0];
		navToSubcategory(subcat_id,section);
	}
}

function showProducts(id)
{
	//shows products for a subcategory and provides navigation for the subcategory
	
	var sc = $(id);
	var subcategory_id = id.substring(3);
	var products;
	if(sc.hasClassName('active') == false)
	{
		if($(id + '_products'))
		{
			products = $$('li#' + id + '_products ul')[0];
			navToSubcategory(subcategory_id,products);
		}
		else
		{
			new Insertion.After(id, '<li id="' + id + '_products"></li>');
			new Ajax.Request('/product/products/' + subcategory_id,{onSuccess: function(request){
				$(id + '_products').update(request.responseText);
				products = $$('li#' + id + '_products ul')[0];
				navToSubcategory(subcategory_id,products);
			}});
		}
	}
	else
	{
		products = $$('li#' + id + '_products ul')[0];
		navToSubcategory(subcategory_id,products);
	}
}

function showSectionProducts(id)
{
	var sec = $(id);
	var section_id = id.substring(3);
	var products;
	
	if(sec.hasClassName('active') == false)
	{
		if($(id + '_products'))
		{
			products = $$('li#' + id + '_products ul')[0];
			navToSection(section_id,products);
		}
		else
		{
			new Insertion.After(id, '<li id="' + id + '_products"></li>');
			new Ajax.Request('/product/section_products/' + section_id,{onSuccess: function(request){
				$(id + '_products').update(request.responseText);
				products = $$('li#' + id + '_products ul')[0];
				sec.addClassName('active');
				navToSection(section_id,products);
			}});
		}
	}
	else
	{
		products = $$('li#' + id + '_products ul')[0];
		navToSection(section_id,products);
	}
}

function navToCategory(id,subNavToShow)
{
	hideSubcats();
	
	if(subNavToShow)
		subNavToShow.show();
	
	$$('ul#categories li').each(function(element)
	{
		element.removeClassName('active');
	});
	
	$('cat' + id).addClassName('active');
	cacheNav();
	nav('/product/view_category/' + id);
}

function hideProducts()
{
	$$('ul#categories li ul li ul').each(function(element){
		//element.hide();
		element.setStyle({display: 'none'});
	});
}

function navToSubcategory(id,productsToShow)
{
	hideProducts();
	
	if(productsToShow)
		productsToShow.show();
	
	$$('ul#categories li ul li').each(function(element)
	{
		element.removeClassName('active');
	});
	
	$('sc_' + id).addClassName('active');
	cacheNav();
	nav('/product/view_subcategory/' + id);
}

function hideSectionProducts()
{
	$$('ul#categories li ul li ul li ul').each(function(element){
		//element.hide();
		element.setStyle({display: 'none'});
	});
}

function navToSection(id,productsToShow)
{
	hideSectionProducts();
	
	if(productsToShow)
		productsToShow.show();
		
	$$('ul#categories li ul li ul li').each(function(element)
	{
		element.removeClassName('active');
	});
	
	$('ps_' + id).addClassName('active');
	
	cacheNav();
	nav('/product/view_section/' + id);
}

function navToProduct(id,subcat_id)
{	
	$('p_' + id).addClassName('active');
	cacheNav();
	nav('/product/view_product/' + id + '?subcat_id=' + subcat_id);
}

function cacheNav()
{
	$('left_nav_cache').value = $('left_nav').innerHTML;
	
	new Ajax.Request('/product/cache_nav',
	{
		parameters: Form.serialize('nav_cache')
	});
}

function nav(url)
{
	document.location.href = url;
}
