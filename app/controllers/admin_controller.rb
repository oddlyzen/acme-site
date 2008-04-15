class AdminController < ApplicationController
  
  layout "admin", :except => :show_images
  
  before_filter :authorize, :except => :login
  
  uses_tiny_mce(:options => {:theme => 'advanced',
                             :browsers => %w{msie gecko},
                             :theme_advanced_toolbar_location => "top",
                             :theme_advanced_toolbar_align => "center",
                             :theme_advanced_resizing => true,
                             :theme_advanced_resize_horizontal => false,
                             :paste_auto_cleanup_on_paste => true,
                             :theme_advanced_blockformats => %{pre,code,samp},
                             :extended_valid_elements => %w{samp[class|dir<ltr?rtl|id|lang|onclick|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style|title],code[class|dir<ltr?rtl|id|lang|onclick|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style|title],cite[title|id|class|style|dir|lang],abbr[title|id|class|style|dir|lang]},
                             :theme_advanced_buttons1 => %w{bold italic strikethrough separator indent outdent separator search replace separator print preview separator},
                             :theme_advanced_buttons2 => [%w{bullist numlist separator link unlink binc_image separator undo redo code}],
                             :theme_advanced_buttons3 => [%w{}],
                             :plugins => %w{contextmenu binc_advimage paste searchreplace preview print inlinepopups}},
                             :only => [:add_news, :edit_news, :edit_category, :add_category, :edit_subcategory, :add_subcategory, :edit_section, :add_section, :edit_product, :add_product])

  # User Administration
  def add_user
    @user = User.new(params[:user])
    if request.post? and @user.save
      flash[:notice] = "User #{@user.user_name} created."
      redirect_to :action => :list_users
      @user = User.new
    end
  end

  def login
    session[:user_id] = nil
    if request.post?
      user = User.authenticate(params[:user_name], params[:password])
      if user
        session[:user_id] = user.id
        uri = session[:original_uri]
        session[:original_uri] = nil
        redirect_to(uri || {:action => 'index'})
      else
        flash.now[:notice] = "Invalid username/password combination."
      end
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "You are logged out."
    redirect_to :action => "login"
  end

  def index
    @user = User.find(session[:user_id])
    @latest_news = Article.find(:first, :order => 'id desc') || nil
    @total_products = Product.find(:all).length
    @total_categories = ProductCategory.find(:all).length
  end

  def delete_user
    if request.post?
      user = User.find(params[:id])
      user.destroy
    end
    flash[:notice] = "User deleted."
    redirect_to(:action => :list_users)
  end

  def list_users
    @all_users = User.find(:all)
  end
  
  def edit_user
    @user = User.find(params[:id])
  end
  
  def update_user
    @user = User.find_by_user_name(params[:user_name])
    if @user and @user.update_attributes(params[:user])
      flash[:notice] = "User updated successfully"
      redirect_to(:action => :list_users)
    end
  end
  
  # News Administration
  def add_news
    @article = Article.new(params[:article])
    @user = User.find(session[:user_id])
    if @user
      @article.user = @user
    end
    if request.post? and @article.save
      flash[:notice] = "News Article titled '#{@article.title}' created."
      redirect_to :action => :list_news
    end
  end
  
  def edit_news
    @article = Article.find(params[:id])
  end
  
  def list_news
    @articles = Article.find(:all, :order => 'id desc')
  end
  
  def update_news
    @article = Article.find(params[:id])
    if @article.update_attributes(params[:article])
      flash[:notice] = "News article updated sucessfully."
      redirect_to(:action => :list_news)
    else
      flash[:notice] = "An error occured."
      render :action => 'edit_news', :id => @article
    end
  end
  
  def delete_news
    if request.post?
      article = Article.find(params[:id])
      article.destroy
    end
    flash[:notice] = "Article deleted successfully."
    redirect_to :action => :list_news
  end
  
  # Image Administration
  def add_image
    
  end
  
  def create_image
    @image = Image.new(:uploaded_data => params[:image_file])
    if request.post? and @image.save
      flash[:notice] = "Image was uploaded successfully."
      redirect_to :action => :index
    else
      flash[:notice] = "An error occurred."
      render :action => :add_image
    end
  end
  
  def show_images
    @images = Image.find(:all)
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  # Category Administration
  def add_category
    @category = ProductCategory.new(params[:category])
    if request.post? and @category.save
      flash[:notice] = "New Category '#{@category.category}' created."
      redirect_to :action => :list_categories
    end
  end
  
  def list_categories
    @categories = ProductCategory.find(:all, :order => 'position asc')
  end
  
  def edit_category
    @category = ProductCategory.find(params[:id])
    @subcategories = @category.product_subcategories.find(:all, :order => 'position asc')
  end
  
  def update_category
    @category = ProductCategory.find(params[:id])
    if @category.update_attributes(params[:category])
      flash[:notice] = "Category #{@category.category} updated."
      redirect_to :action => :list_categories
    else
      flash[:notice] = "An error occured."
      render :action => :edit_category, :id => @category
    end
  end
  
  def delete_category
    if request.post?
      category = ProductCategory.find(params[:id])
      category.destroy
    end
    flash[:notice] = "Category deleted successfully."
    render :action => :list_categories
  end
  
  # Subcategory Administration
  def add_subcategory
    @category = ProductCategory.find(params[:category_id])
    @subcategory = ProductSubcategory.new(params[:subcategory])
    @subcategory.product_category = @category
    if request.post? and @subcategory.save
      flash[:notice] = "New Subcategory '#{@subcategory.subcategory}' created."
      redirect_to :action => :edit_category, :id => @category
    end
  end
  
  def list_subcategories
    @subcategories = ProductSubcategory.find(:all, :order => 'position asc')
  end
  
  def edit_subcategory
    @subcategory = ProductSubcategory.find(params[:id])
    @subcategory.products = @subcategory.products.sort_by{|i| i.position}
  end
  
  def update_subcategory
    @subcategory = ProductSubcategory.find(params[:id])
    if @subcategory.update_attributes(params[:subcategory])
      flash[:notice] = "Subcategory '#{@subcategory.subcategory}' updated."
      redirect_to :action => :edit_category, :id => @subcategory.product_category
    else
      flash[:notice] = "An error occurred."
      render :action => :edit_subcategory, :id => @subcategory
    end
  end
  
  def delete_subcategory
    if request.post?
      subcategory = ProductSubcategory.find(params[:id])
      subcategory.destroy
      flash[:notice] = "Subcategory deleted successfully."
      render :action => :edit_category, :id => subcategory.product_category
    end
  end
  
  # Section Administration
  def add_section
    @subcategory = ProductSubcategory.find(params[:subcategory_id])
    @section = ProductSection.new(params[:section])
    @section.product_subcategory = @subcategory
    if request.post? and @section.save
      flash[:notice] = "New Section #{@section.section} created."
      redirect_to :action => :edit_subcategory, :id => @subcategory
    end
  end
  
  def list_sections
    @sections = ProductSection.find(:all, :order => 'position asc')
  end
  
  def edit_section
    @section = ProductSection.find(params[:id])
    @section.products = @section.products.sort_by{|i| i.position}
  end
  
  def update_section
    @section = ProductSection.find(params[:id])
    if @section.update_attributes(params[:section])
      flash[:notice] = "Section '#{@section.section}' updated."
      redirect_to :action => :edit_subcategory, :id => @section.product_subcategory
    else
      flash[:notice] = "An error occurred."
      render :action => :edit_section, :id => @section
    end
  end
  
  def delete_section
    if request.post?
      section = ProductSection.find(params[:id])
      section.destroy
      flash[:notice] = "Section deleted successfully."
      render :action => :edit_subcategory, :id => section.product_subcategory
    end
  end
  
  
  # Product Administration
  def add_product
    @product = Product.new(params[:product])
    @parent = nil
    if params[:section_id]
      @parent = ProductSection.find(params[:section_id])
    end
    if params[:subcategory_id]
      @parent = ProductSubcategory.find(params[:subcategory_id])
    end
    if request.post? and @product.save
      if @parent
        @parent.products << @product
      end
      flash[:notice] = "New Product '#{@product.product}' created."
      redirect_to :action => :list_products
    end
  end
  
  def add_product_to_section
    @product = Product.find(params[:product_id])
    @parent = ProductSection.find(params[:id])
    @parent.products << @product
    @products = find_remaining_products(@parent)
    respond_to do |format|
      format.html
      format.js {
        render :action => :update_product_management
      }
    end
  end
  def add_product_to_subcategory
    @product = Product.find(params[:product_id])
    @parent = ProductSubcategory.find(params[:id])
    @parent.products << @product
    @products = find_remaining_products(@parent)
    respond_to do |format|
      format.html
      format.js {
        render :action => :update_product_management
      }
    end
  end
  
  def remove_product_from_section
    @parent = ProductSection.find(params[:id])
    @product = Product.find(params[:product_id])
    @parent.products.delete(@product)
    @parent.save!
    @products = find_remaining_products(@parent)
    respond_to do |format|
      format.html
      format.js {
        render :action => :update_product_management
      }
    end
  end
  def remove_product_from_subcategory
    @parent = ProductSubcategory.find(params[:id])
    @product = Product.find(params[:product_id])
    @parent.products.delete(@product)
    @parent.save!
    @products = find_remaining_products(@parent)
    respond_to do |format|
      format.html
      format.js {
        render :action => :update_product_management
      }
    end
  end
  
  def manage_section_products
    @parent = ProductSection.find(params[:id])
    @products = find_remaining_products(@parent)
    @parent_name = @parent.section
    @parent.products = @parent.products.sort_by { |o| o.position }
  end
  
  def manage_subcategory_products
    @parent = ProductSubcategory.find(params[:id])
    @products = find_remaining_products(@parent)
    @parent_name = @parent.subcategory
    @parent.products = @parent.products.sort_by { |o| o.position }
  end
  
  def sort_products
    @products = params["parent-products-list"]
    @products.each_index { |i|
      p = Product.find(@products[i])
      p.position = i+1
      p.save
    }
    respond_to do |format|
      format.html
      format.js {
        render :action => :update_product_management
      }
    end
  end
  
  def list_products
    @products = Product.find(:all, :order => 'id desc')
  end
  
  def edit_product
    @product = Product.find(params[:id])
  end
  
  def update_product
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product])
      flash[:notice] = "Product '#{@product.product}' updated."
      redirect_to :action => :list_products
    else
      flash[:notice] = "An error occurred."
      render :action => :edit_product, :id => @product
    end
  end
  
  def delete_product
    if request.post?
      p = Product.find(params[:id])
      p.destroy
      flash[:notice] = "Product deleted successfully."
      render :action => :list_products
    end
  end
 
 
  protected
  
  def find_remaining_products(parent)
    prods = Product.find(:all, :order => 'id desc')
    parent.products.each do |p|
      prods.delete(p)
    end
    prods
  end
  
  
  
  private
  
  
end
