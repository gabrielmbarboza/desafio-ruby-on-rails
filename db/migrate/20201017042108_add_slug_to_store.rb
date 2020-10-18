class AddSlugToStore < ActiveRecord::Migration[5.2]
  def change
    add_column :stores, :slug, :string, null:false
  end
end
