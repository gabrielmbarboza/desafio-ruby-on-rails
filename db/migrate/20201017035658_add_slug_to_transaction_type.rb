class AddSlugToTransactionType < ActiveRecord::Migration[5.2]
  def change
    add_column :transaction_types, :slug, :string, null: false
  end
end
