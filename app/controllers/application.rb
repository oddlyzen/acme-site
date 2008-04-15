# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
	# Pick a unique cookie name to distinguish our session data from others'
	session :session_key => '_acme_session_id'
  
	def optional_js_include(src)
  		return('<script src="/javascripts/' + src + '.js" type="text/javascript"></script>')
  end
  
  def clear_nav_cache
    session[:nav_cache] = nil
  end
  
  # Used to Assemble a Title for Views in the format:
  # 'Acme Environmental Products - (Sub Title) - (Detail Title)
  def mod_title(s1=nil, s2=nil)
    unless s1.nil?
		  @page_title += " - #{s1}"
		end
		unless s2.nil?
		  @page_title += " - #{s2}"
	  end
  end
  
  private
  
  def authorize
    unless User.find_by_id(session[:user_id])
      session[:original_uri] = request.request_uri
      flash[:notice] = "Please log in."      
      redirect_to(:controller => "admin", :action => "login")
    end
  end
  
end