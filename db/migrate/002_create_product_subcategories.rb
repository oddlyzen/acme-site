class CreateProductSubcategories < ActiveRecord::Migration
  def self.up
    create_table :product_subcategories do |t|
    	t.column :product_category_id, :integer, :null => false
    	t.column :position, :integer, :null => false
    	t.column :subcategory, :string, :null => false
    	t.column :active, :boolean, :null => false
    end
  end

  def self.down
    drop_table :product_subcategories
  end
end