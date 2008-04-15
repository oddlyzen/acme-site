class SpillResponseServiceController < ApplicationController
	
	def index
    clear_nav_cache() 
		@page_title = 'Acme Environmental Spill Response Services'
		@body_class = 'srs'
	end
	
end