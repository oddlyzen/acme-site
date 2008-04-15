class CreateSubcategoryAccessories < ActiveRecord::Migration
  def self.up
    create_table :subcategory_accessories do |t|
    	t.column :product_subcategory_id, :integer, :null => false
    	t.column :accessory_id, :integer, :null => false
    end
  end

  def self.down
    drop_table :subcategory_accessories
  end
end