class SitemapController < ApplicationController
	
	def index
		@page_title = 'Acme Environmental Sitemap'
		@body_class = 'sitemap'
	end
	
end