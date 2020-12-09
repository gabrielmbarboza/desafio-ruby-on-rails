class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :itr, null: false

      t.timestamps
    end
  end
end
