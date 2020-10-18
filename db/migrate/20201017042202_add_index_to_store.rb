class AddIndexToStore < ActiveRecord::Migration[5.2]
  def change
    add_index :stores, :slug, :unique => true
  end
end
