require 'swagger_helper'

describe 'Customers API Documentation' do

  path '/customers' do

    post 'Creates a customer' do
      tags 'customer'
      consumes 'application/json'
      parameter name: :customer, in: :body, schema: {
        type: :object,
        properties: {
          itr: { type: :string },
        },
        required: [ 'itr' ]
      }

      response '201', 'blog created' do
        let(:customer) { { itr: '11111111111' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:customer) { { itr: '1111111111111' } }
        run_test!
      end
    end
  end

  path '/customers/{id}' do

    get 'Retrieves a customer' do
      tags 'customers'
      produces 'application/json', 'application/xml'
      parameter name: :id, in: :path, type: :string

      response '200', 'customer found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            itr: { type: :string },
          },
          required: [ 'id', 'itr' ]

        let(:id) { customer.create(itr: 'foo').id }
        run_test!
      end

      response '404', 'customer not found' do
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