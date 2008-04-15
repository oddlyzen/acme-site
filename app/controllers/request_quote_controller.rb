class RequestQuoteController < ApplicationController
	
	def index
		@page_title = 'Request a Quote from Acme Environmental'
		@body_class = 'request_quote'
	end
	
end