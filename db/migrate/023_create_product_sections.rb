class CreateProductSections < ActiveRecord::Migration
  def self.up
    create_table :product_sections do |t|
    end
  end

  def self.down
    drop_table :product_sections
  end
end
