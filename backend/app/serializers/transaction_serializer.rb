class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :type, :amount, :creditcard, :itr,
             :transaction_date, :transaction_hour

  def type
    self.object.transaction_type.label
  end

  def amount
    if self.object.transaction_type.operation === 'D'
      (self.object.amount * (-1)).to_money.format
    else
      self.object.amount.to_money.format
    end
    
  end

  def transaction_date
    self.object.performed_at.strftime("%d/%m/%Y")
  end

  def transaction_hour
    self.object.performed_at.strftime("%H:%M:%S")
  end

  def itr
    cpf = CPF.new(self.object.customer.itr)
    cpf.formatted
  end
end