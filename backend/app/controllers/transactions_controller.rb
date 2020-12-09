class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :update, :destroy]
  before_action :set_store, only: [:index]

  # GET /transactions
  def index
    if(@store.present?)
      @transactions = Transaction.where(store: @store)
      
      serializedList = @transactions.map do |transaction|
        TransactionSerializer.new(transaction).as_json
      end
      
      balance = StoreService.new.balance(@store)
      
      balance_status = balance >= 0 ? "positive" : "negative" 

      render json: {
        store_name: @store.name,
        store_owner: @store.owner,
        balance: balance.to_money.format,
        balance_status: balance_status,
        transactions: serializedList,
      }
    else
      render json: []
    end
  end

  # GET /transactions/1
  def show
    render json: @transaction
  end

  # POST /transactions
  def create
    @transaction = Transaction.new(transaction_params)

    if @transaction.save
      render json: @transaction, status: :created, location: @transaction
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /transactions/1
  def update
    if @transaction.update(transaction_params)
      render json: @transaction
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  def upload
    if params[:cnab].present?
      TransactionService.new(params[:cnab]).call
    end
  end

  # DELETE /transactions/1
  def destroy
    @transaction.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    def set_store
      @store = Store.find(params[:store_id])
    end

    # Only allow a trusted parameter "white list" through.
    def transaction_params
      params.require(:transaction).permit(:amount, :creditcard, :performed_at, :store_id, :customer_id, :transaction_type_id)
    end
end
