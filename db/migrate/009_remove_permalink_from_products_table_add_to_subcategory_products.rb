class RemovePermalinkFromProductsTableAddToSubcategoryProducts < ActiveRecord::Migration
  def self.up
  	remove_column :products, :permalink
  	add_column :subcategory_products, :permalink, :string, :limit => 50
  end

  def self.down
  	remove_column :subcategory_products, :permalink
  	add_column :products, :permalink, :string, :limit => 50
  end
end