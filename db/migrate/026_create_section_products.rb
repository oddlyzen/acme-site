class CreateSectionProducts < ActiveRecord::Migration
  def self.up
    create_table :section_products do |t|
    end
  end

  def self.down
    drop_table :section_products
  end
end
