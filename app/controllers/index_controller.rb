class IndexController < ApplicationController
	
	def index
    clear_nav_cache() 
		@page_title = 'Welcome to Acme Environmental'
		@body_class = 'index'
	end
	
end