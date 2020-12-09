require 'swagger_helper'

describe 'Transaction Types API Documentation' do

  path '/transaction-types' do
    post 'Creates a transaction type' do
      tags 'Transaction Type'
      consumes 'application/json'
      parameter name: :transaction_type, in: :body, schema: {
        type: :object,
        properties: {
          label: { type: :string },
          operation: { type: :string },
          code: { type: :integer },
        },
        required: [ 'label', 'operation', 'code' ]
      }

      response '201', 'Transaction Type created' do
        let(:transaction_type) { create(:transaction_type) }
        run_test!
      end

      response '422', 'invalid request' do
        let(:transaction_type) { { label: nil } }
        run_test!
      end
    end
  end

  path '/transaction-types' do
    get 'Retrieves all transaction types' do
      tags 'Transaction Type'
      produces 'application/json', 'application/xml'
      
      response 200, 'Transaction Types found' do
        before { create_list(:transaction_type, 3) }
        run_test!
      end
    end
  end

  path '/transaction-types/{id}' do
    parameter name: :id, in: :path, type: :integer

    get 'Retrieves a transaction type' do
      produces 'application/json'
      parameter name: :transaction_type, in: :body
 
      response '200', 'Transction type found' do
        let(:transaction_type1) { create(:transaction_type) }
        let(:id) { transaction_type1.id }
      end
 
      response '404', 'transaction not found' do
        let(:id) { -1 }
      end
    end

    patch 'Updates a transaction' do
      tags 'Transaction Type'
      consumes 'application/json'
      parameter name: :transaction_type, in: :body
      
      let(:transaction_type2) { create(:transaction_type) }
      let(:id) { transaction_type2.id }
      
      response '200', 'Transaction type updated' do
        let(:transaction_type) do 
          {
            label: "Credit Card",
            operation: 'C',
            code: rand(1..100)
          }
        end
        run_test!
      end
    
      response '422', 'invalid request' do
        let(:transaction_type) { { label: nil } }
        run_test!
      end
    end
  end

  path '/transaction-types/{id}' do
    delete 'Delete a Transaction Type' do
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer
      produces 'application/json'
 
      response '204', 'Destroy the Transaction Type' do
        let(:id) { create(:transaction_type).id }
        run_test!
      end
    end
  end
end