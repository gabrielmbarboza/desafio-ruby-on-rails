class AddCodeToTransactionType < ActiveRecord::Migration[5.2]
  def change
    add_column :transaction_types, :code, :integer, null: false
  end
end
