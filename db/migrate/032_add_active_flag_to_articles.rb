class AddActiveFlagToArticles < ActiveRecord::Migration
  def self.up
    add_column :articles, :active, :boolean, { :default => false }
  end

  def self.down
    remove_column :articles, :active
  end
end
