class CreateTransactionTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :transaction_types do |t|
      t.string :name, null: false
      t.string :operation, null: false

      t.timestamps
    end
  end
end
