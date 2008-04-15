class AboutController < ApplicationController
	
	def index
    clear_nav_cache() 
		@page_title = 'About Acme Environmental'
		@body_class = 'about'
		@optional_js_include = optional_js_include('about')
	end
	
end