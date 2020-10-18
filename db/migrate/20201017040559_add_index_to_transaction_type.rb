class AddIndexToTransactionType < ActiveRecord::Migration[5.2]
  def change
    add_index :transaction_types, :slug, :unique => true
  end
end
