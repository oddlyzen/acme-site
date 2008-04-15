class NewsController < ApplicationController
	
	def index
    clear_nav_cache() 
		@page_title = 'Acme Environmental News'
		@body_class = 'news'
		@articles = Article.find(:all, :conditions => ["active = ?", true], :limit => 5, :include => [:user]).sort_by{|x| x.updated_at}
		@archived_news = get_archives(@articles)
	end
	
	def article
	  clear_nav_cache() 
		@body_class = 'news'
	  @article = Article.find(params[:id])
	  @page_title = 'Acme Environmental News - ' + @article.title
  end
	
	protected
	
	def get_archives(current)
	  archives = Article.find(:all, :conditions => ["active = ?", true], :include => [:user])
	  current.each do |a|
	    archives.delete(a)
    end
    archives.sort_by{|x| x.updated_at}
  end
	
end