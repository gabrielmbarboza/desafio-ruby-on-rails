class StoreService
  def balance(store)
    sql = <<-SQL 
      SELECT
        SUM(CASE
          WHEN transaction_types.operation = 'D' THEN -transactions.amount
          ELSE transactions.amount
        END) AS balance
        FROM transactions
        INNER JOIN stores ON transactions.store_id = stores.id
        INNER JOIN transaction_types ON transactions.transaction_type_id = transaction_types.id
      WHERE stores.id = #{ store.id }
    SQL
    result = execute_sql(sql)&.first
    result["balance"].to_f
  end

  private 

  def execute_sql(sql)
    conn = ActiveRecord::Base.connection
    conn.select_all(sql)
  end
end