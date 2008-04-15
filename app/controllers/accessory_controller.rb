class AccessoryController < ApplicationController
	
	def view
    rescue ActiveRecord::RecordNotFound 
      redirect_to :controller => 'index', :action => 'index'
    else
      @accessory = Accessory.find(params[:id])
    end
	end
	
end