require 'swagger_helper'

describe 'Transactions API Documentation' do

  path '/transactions' do
    post 'Creates a transaction' do
      tags 'Transaction'
      consumes 'application/json'
      parameter name: :transaction, in: :body, schema: {
        type: :object,
        properties: {
          amount: { type: :decimal },
          creditcard: { type: :string },
          performed_at: { type: :datetime },
          store_id: { type: :integer },
          customer_id: { type: :integer },
          transaction_type_id: { type: :integer }
        },
        required: [ 'amount', 'performed_at' ]
      }

      response '201', 'Transaction created' do
        let(:transaction) { create(:transaction) }
        run_test!
      end

      response '422', 'invalid request' do
        let(:transaction) { { amount: '' } }
        run_test!
      end
    end
  end

  path '/transactions' do
    get 'Retrieves all transactions. By store' do
      tags 'Transaction'
      produces 'application/json', 'application/xml'
      parameter name: :store_id, in: :query, type: :integer
      let(:store) { create(:store) }
      let(:store_id) { store.id }
      
      response 200, 'Transactions found' do
        before { create_list(:transaction, 3) }
        run_test!
      end
    end
  end

  path '/transactions/{id}' do
    parameter name: :id, in: :path, type: :integer

    get 'Retrieves a transaction.' do
      produces 'application/json'
      parameter name: :transaction, in: :body
 
      response '200', 'Transction found' do
        let(:transaction1) { create(:transaction) }
        let(:id) { transaction1.id }
      end
 
      response '404', 'transaction not found' do
        let(:id) { -1 }
      end
    end

    patch 'Updates a transaction' do
      tags 'Transaction'
      consumes 'application/json'
      parameter name: :transaction, in: :body
      
      let(:transaction2) { create(:transaction) }
      let(:id) { transaction2.id }
      
      response '200', 'Transaction updated' do
        let(:transaction) do 
          {
            amount: 300.0,
            performed_at: '31/12/2020 01:00:00',
            creditcard: '2222222222222222'
          }
        end
        run_test!
      end
    
      response '422', 'invalid request' do
        let(:transaction) { { amount: nil } }
        run_test!
      end
    end
  end

  path '/transactions/{id}' do
    delete 'Delete a Transaction' do
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer
      produces 'application/json'
 
      response '204', 'Destroy the Transaction' do
        let(:id) { create(:transaction).id }
        run_test!
      end
    end
  end
end