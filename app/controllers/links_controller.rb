class LinksController < ApplicationController
	
	def index
    clear_nav_cache() 
		@page_title = 'Acme Environmental Helpful Links'
		@body_class = 'links'
    @links = Link.find(:all, :order => 'position asc')
    
    rescue ActiveRecord::RecordNotFound
      redirect_to :controller => 'index', :action => 'index'

	end
	
end