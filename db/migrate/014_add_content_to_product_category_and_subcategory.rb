class AddContentToProductCategoryAndSubcategory < ActiveRecord::Migration
  def self.up
  	add_column :product_categories, :content, :text
  	add_column :product_subcategories, :content, :text
  end

  def self.down
  	remove_column :product_categories, :content
  	remove_column :product_subcategories, :content
  end
end