class CreateProductAccessories < ActiveRecord::Migration
  def self.up
    create_table :product_accessories do |t|
    	t.column :product_id, :integer, :null => false
    	t.column :accessory_id, :integer, :null => false
    end
  end

  def self.down
    drop_table :product_accessories
  end
end