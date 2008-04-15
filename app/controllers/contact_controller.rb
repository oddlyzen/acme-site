class ContactController < ApplicationController
	
	def index
    clear_nav_cache() 
		@page_title = 'Contact Acme Environmental'
		@body_class = 'contact'
		@optional_js_include = optional_js_include('contact')
	end
	
end