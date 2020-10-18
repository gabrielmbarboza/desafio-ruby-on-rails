class TransactionService
  def initialize(cnab64)
    cnab_lines = Base64.decode64(cnab64)
    @cnab_list = cnab_lines.split("\n") if cnab_lines.present?
  end

  def call
    raise StandardError.new("O arquivo CNAB está vazio.") unless  @cnab_list.present?
    
    @cnab_list.map do |cnab|
      params = to_transaction_params(cnab)
      raise StandardError.new "Transaction type not found" unless params.present?

      Transaction.create!(params)
    end
  end

  private

  attr_reader :cnab64

  def to_transaction_params(cnab)
    t_code = (cnab[0]).strip
    t_date = normalize_date((cnab[1..8]).strip)
    amount = ((cnab[9..18]).strip).to_f
    itr = (cnab[19..29]).strip
    creditcard = (cnab[30..41]).strip
    t_time = Time.new((cnab[42..47]).strip).strftime("%H:%M:%S")
    store_owner = (cnab[48..61]).strip
    store_name = (cnab[62..80]).strip

    puts amount

    puts itr

    puts creditcard

    store = find_or_create_store(store_name, store_owner)
    raise StandardError.new "Store not found" unless store.present?
      
    customer = find_or_create_customer(itr)
    raise StandardError.new "Customer not found" unless customer.present?
      
    type = find_transaction_type(t_code)
    
    raise StandardError.new "Transaction type not found" unless type.present?

    {
      amount: amount, t_date: t_date, t_time: t_time,
      creditcard: creditcard, store: store, customer: customer,
      transaction_type: type
    }
  end

  def normalize_date(str_date)
    year = str_date[0..3]
    month = str_date[4..5]
    day = str_date[6..7]

    Date.strptime("#{year}-#{month}-#{day}", '%Y-%m-%d')
  end

  def find_or_create_store(name, owner)
    slug = name&.parameterize
    
    Store.find_or_create_by(slug: slug) do |store|
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