class ProductSection < ActiveRecord::Migration
  def self.up
    create_table :product_sections do |t|
      t.column :product_subcategory_id, :integer
      t.column :position, :integer
      t.column :section, :string
      t.column :short_desc, :string
      t.column :list_image, :string
      t.column :width, :integer
      t.column :height, :integer
      t.column :content, :text
      t.column :active, :boolean
    end
  end

  def self.down
    drop_table :product_sections
  end
end