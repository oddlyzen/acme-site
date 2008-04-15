class CreateSubcategoryProducts < ActiveRecord::Migration
  def self.up
    create_table :subcategory_products do |t|
    	t.column :product_subcategory_id, :integer, :null => false
    	t.column :product_id, :integer, :null => false
    end
  end

  def self.down
    drop_table :subcategory_products
  end
end
