class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.decimal :amount, null: false
      t.string :creditcard
      t.date :t_date, null: false
      t.time :t_time, null: false
      t.references :store, foreign_key: true
      t.references :customer, foreign_key: true
      t.references :transaction_type, foreign_key: true

      t.timestamps
    end
  end
end
