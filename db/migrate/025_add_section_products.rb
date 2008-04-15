class AddSectionProducts < ActiveRecord::Migration
  def self.up
    create_table :section_products do |t|
      t.column :product_section_id, :integer, :null => false
      t.column :product_id, :integer, :null => false
    end
  end

  def self.down
    drop_table :section_products
  end
end