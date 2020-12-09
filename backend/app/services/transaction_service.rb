class TransactionService
  def initialize(cnab64)
    cnab64_splitted = cnab64.split(',')
    cnab_lines = Base64.decode64(cnab64_splitted.pop)
    @cnab_list = cnab_lines.split("\n") if cnab_lines.present?
  end

  def call
    raise StandardError.new("O arquivo CNAB está vazio.") unless  @cnab_list.present?
    @cnab_list.map do |cnab|
      params = to_transaction_params(cnab)
      Transaction.create!(params)
    end    
  end

  private

  attr_reader :cnab64

  def to_transaction_params(cnab)
    t_code = (cnab[0]).strip
    t_date = (cnab[1..8]).strip
    amount = ((cnab[9..18]).strip).to_f / 100.00
    itr = (cnab[19..29]).strip
    creditcard = (cnab[30..41]).strip
    t_hours = (cnab[42..47]).strip
    store_owner = (cnab[48..61]).strip
    store_name = (cnab[62..80]).strip

    performed_at = normalize_date(t_date, t_hours)
      
    store = find_or_create_store(store_name, store_owner)
    raise StandardError.new "Store not found" unless store.present?
      
    customer = find_or_create_customer(itr)
    raise StandardError.new "Customer not found" unless customer.present?
      
    type = find_transaction_type(t_code)
    
    raise StandardError.new "Transaction type not found" unless type.present?

    {
      amount: amount, performed_at: performed_at, creditcard: creditcard, 
      store: store, customer: customer, transaction_type: type
    }
  end

  def normalize_date(str_date, str_hours)
    year = str_date.scan(/.{4}/)
   
    month_day = year.pop.scan(/.{2}/)
    
    n_date = year.concat(month_day).join('-')
    n_hours = normalize_hours(str_hours)
 
    DateTime.strptime("#{n_date} #{n_hours}", '%Y-%m-%d %H:%M:%S')
  end

  def normalize_hours(str_hours)
    str_hours.scan(/.{2}/).join(':')
  end

  def find_or_create_store(name, owner)
    
    Store.find_or_create_by(name: name) do |store|
      store.name = name
      store.owner = owner
    end
  end

  def find_or_create_customer(itr)
     Customer.find_or_create_by(itr: itr)
  end

  def find_transaction_type(code)
    TransactionType.find_by(code: code) if code.present?
  end
end