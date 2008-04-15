class RemoveFkFromProductsAddContentColumn < ActiveRecord::Migration
  def self.up
  	remove_column :products, :product_subcategory_id
  	add_column :products, :content, :text
  end

  def self.down
  end
end