module ProductHelper
	
	def extra_content(subcategory_id)
		if subcategory_id == 5 #sorbents
			sorbent_chem_compat()
		end
	end
	
	def sorbent_chem_compat
		html = '<dl>' + "\n"
		html << '<dt><img src="/images/chem_compat_icon.jpg" width="56" height="52" alt="Checmical compatibility guide" /></dt>' + "\n"
		html <<	'<dd>Chemical Compatibility Guide for Sorbents: ' << link_to('Click here', {:controller => 'index', :action => 'index'}, {:title => 'Chemical Compatibility Guide for Sorbents'}) << '</dd>' + "\n"
		html << '</dl>'
	end
	
end