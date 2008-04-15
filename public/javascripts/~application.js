Event.observe(window, 'load', function(){
	
	var nav_html;
	new Ajax.Request('/product/restore_nav',
	{	onSuccess: function(request)
		{
			nav_html = request.responseText;
			if(nav_html != '' && nav_html != null)
			{
				$('left_nav').update(nav_html);
				$('categories_container').setStyle({display: 'block'})
			}
			else
				new Effect.BlindUp('categories_container', duration = 0)
			
		}
	});
	
	//remove back link for product if JavaScript is enabled
	var products_back_link = $('products_back');
	if(products_back_link)
		products_back_link.remove();
});


function showCategories()
{
	var pc = $('categories_container');
	
	if(pc.visible() == false)
	{
		//check for presence of categories, ajax in if necessary, otherwise just show
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
	
	cacheNav();
	return false;
}

function showSubcategories(id)
{
	var cat = $(id);
	if(cat.hasClassName('active') == false)
	{
		if($(id + '_subcats'))
		{
			if($(id + '_subcats').visible() == false && $$('li#' + id + '_subcats ul li').length > 0)
				new Effect.BlindDown(id + '_subcats', duration = 0.25);
		}
		else
		{
			new Insertion.After(id, '<li id="' + id + '_subcats"></li>');
			new Ajax.Request('/product/subcategories/' + id.substring(3),{onSuccess: function(request){
				$(id + '_subcats').update(request.responseText);
				if($$('li#' + id + '_subcats ul li').length > 0)
					new Effect.BlindDown(id + '_subcats', duration = 0.25);
			}});
		}
		
		$$('ul#categories li').each(function(element){
			element.removeClassName('active');
		});
		
		cat.addClassName('active');
	}
	else
	{
		cat.removeClassName('active');
		new Effect.BlindUp(id + '_subcats', duration = 0.25);
	}
	
	cacheNav();
	return false;
}

function showProducts(id)
{
	var sc = $(id);
	if(sc.hasClassName('active') == false)
	{
		if($(id + '_products'))
		{
			if($(id + '_products').visible() == false && $$('li#' + id + '_products ul li').length > 0)
				new Effect.BlindDown(id + '_products', duration = 0.25);
		}
		else
		{
			new Insertion.After(id, '<li id="' + id + '_products"></li>');
			new Ajax.Request('/product/products/' + id.substring(3),{onSuccess: function(request){
				$(id + '_products').update(request.responseText);
				if($$('li#' + id + '_products ul li').length > 0)
					new Effect.BlindDown(id + '_products', duration = 0.25);
			}});
		}
		
		$$('ul#categories li ul li').each(function(element){
			element.removeClassName('active');
		});
		
		sc.addClassName('active');
	}
	else
	{
		sc.removeClassName('active');
		new Effect.BlindUp(id + '_products', duration = 0.25);
	}

	cacheNav();
	return false;
}

function navToCategory(id)
{
	$$('ul#categories li').each(function(element)
	{
		element.removeClassName('active');
	});
	
	$('cat' + id).addClassName('active');
	cacheNav();
	nav('/product/view_category/' + id);
}

function navToSubcategory(id)
{
	$$('ul#categories li ul li').each(function(element)
	{
		element.removeClassName('active');
	});
	
	$('sc_' + id).addClassName('active');
	cacheNav();
	nav('/product/view_subcategory/' + id);
}

function navToProduct(id,subcat_id)
{
	$$('ul#categories li ul li ul li').each(function(element){
		element.removeClassName('active');
	});
	
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
