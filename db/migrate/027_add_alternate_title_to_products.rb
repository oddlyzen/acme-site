class AddAlternateTitleToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :alternate_title, :string
  end

  def self.down
    remove_column :products, :alternate_title
  end
end