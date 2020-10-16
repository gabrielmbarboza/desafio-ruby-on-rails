require 'swagger_helper'

describe 'Transaction Types API Documentation' do

  path '/transaction-types' do

    post 'Creates a transaction type' do
      tags 'Transaction-Type'
      consumes 'application/json'
      parameter name: :transaction_type, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          operation: { type: :string }
        },
        required: [ 'name', 'operation' ]
      }

      response '201', 'transaction created' do
        let(:transaction_type) { { name: 'foo', operation: 'C' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:transaction_type) { { name: '' } }
        run_test!
      end
    end
  end

  path '/transaction_types/{id}' do

    get 'Retrieves a transaction_type' do
      tags 'transaction_types'
      produces 'application/json', 'application/xml'
      parameter name: :id, in: :path, type: :string

      response '200', 'transaction_type found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            operation: { type: :string },
          },
          required: [ 'id', 'name', 'operation' ]

        let(:id) { transaction_type.create(name: 'foo', operation: 'C').id }
        run_test!
      end

      response '404', 'transaction_type not found' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:'Accept') { 'application/foo' }
        run_test!
      end
    end
  end
end