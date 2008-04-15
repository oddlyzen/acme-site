class ProductController < ApplicationController
	
	before_filter :init_products
	
	def categories
	  
    @categories = ProductCategory.find(:all, :conditions => ['active = 1'], :order => 'position asc')
    mod_title("Categories")
      respond_to do |format|
        format.html { render }
        format.js { render :partial => 'categories', :layout => false }
      end
  end
	
	def view_category
    @category = find_category(params[:id])
    @subcategories = @category.product_subcategories.find(:all, :conditions => ['active = 1'], :order => 'position asc')
    mod_title(@category.category)
    
	end
	
	def subcategories
    @category = find_category(params[:id])
    @subcategories = @category.product_subcategories.find(:all, :conditions => ['active = 1'], :order => 'position asc')
    mod_title(@category.category)
    respond_to do |format|
      format.html { render }
      format.js { render :partial => 'subcategories', :layout => false }
    end
  end
  
  def view_subcategory
    @subcategory = find_subcategory(params[:id])
    @sections = @subcategory.product_sections.find(:all, :conditions => ['active = 1'], :order => 'position asc')
    @products = @subcategory.products.find(:all, :order => 'position asc')
    @category = find_category(@subcategory.product_category_id)
    @accessories = @subcategory.accessories.find(:all, :order => 'position asc')
    mod_title(@category.category)
  end
	
  def sections
    @subcategory = find_subcategory(params[:id])
    @sections = @subcategory.product_sections.find(:all, :conditions => ['active = 1'], :order => 'position asc')
    mod_title(@category.category)
  
    respond_to do |format|
      format.html { render }
      format.js { render :partial => 'sections', :layout => false }
    end
  end
  
  def view_section
    @section = ProductSection.find(params[:id])
    @subcategory = find_subcategory(@section.product_subcategory_id)
    @products = @section.products.find(:all, :order => 'position asc')
    @category = find_category(@subcategory.product_category_id)
    mod_title(@category.category, @section.section)
  end
  
	def products
		@subcategory = find_subcategory(params[:id])
    @category = find_category(@subcategory.product_category_id)
    @products = @subcategory.products.find(:all, :order => 'position asc')
    mod_title(@category.category)
    
    respond_to do |format|
      format.html { render }
      format.js { render :partial => 'products', :layout => false }
    end
  end

  def section_products
    @section = ProductSection.find(params[:id])
    @subcategory = find_subcategory(@section.product_subcategory_id)
    @category = find_category(@subcategory.product_category_id)
    @products = @section.products.find(:all, :order => 'position asc')
    mod_title(@category.category, @section.section)
    
    respond_to do |format|
      format.js { render :partial => 'products', :layout => false }
    end
  end
	
	def view_product
		@product = Product.find(params[:id])
		
		
    rescue ActiveDirectory::RecordNotFound
      redirect_on_error
    else
      @subcategory = find_subcategory(params[:subcat_id])
      @category = find_category(@subcategory.product_category_id)
      mod_title(@category.category, @product.product)
	end
	
	def cache_nav
		session[:nav_cache] = params[:left_nav_cache]
		
		respond_to do |format|
			format.js { render :partial => 'cache_nav', :layout => false }
		end
	end
	
	def restore_nav
		@nav_html = session[:nav_cache]
		
		respond_to do |format|
			format.js { render :partial => 'left_nav_cache', :layout => false }
		end
	end
	
	def find_category(product_subcategory_id)
		@category = ProductCategory.find(product_subcategory_id)
    
    rescue ActiveRecord::RecordNotFound
      redirect_on_error
	end
	
	def find_subcategory(id)
		@subcategory = ProductSubcategory.find(id)
    
    rescue ActiveRecord::RecordNotFound
      redirect_on_error
  end
  
  private
  def redirect_on_error
    redirect_to :controller => 'index', :action => 'index'
  end
  
  def style_products
    clear_nav_cache() 
		@page_title = 'Acme Environmental Products'
		@body_class = 'categories'
		@optional_js_include = optional_js_include('products')
  end
  
  alias init_products style_products
  
end