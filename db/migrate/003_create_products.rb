class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
    	t.column :product_subcategory_id, :integer, :null => false
    	t.column :position, :integer, :null => false
    	t.column :product, :string, :null => false
    	t.column :price, :decimal, :precision => 8, :scale => 2
    end
  end

  def self.down
    drop_table :products
  end
end