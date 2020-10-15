require 'swagger_helper'

describe 'Stores API Documentation' do

  path '/stores' do

    post 'Creates a store' do
      tags 'Store'
      consumes 'application/json'
      parameter name: :store, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          owner: { type: :string }
        },
        required: [ 'name', 'owner' ]
      }

      response '201', 'blog created' do
        let(:store) { { name: 'foo', owner: 'bar' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:store) { { name: 'foo' } }
        run_test!
      end
    end
  end

  path '/stores/{id}' do

    get 'Retrieves a store' do
      tags 'Stores'
      produces 'application/json', 'application/xml'
      parameter name: :id, in: :path, type: :string

      response '200', 'store found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            owner: { type: :string }
          },
          required: [ 'id', 'name', 'owner' ]

        let(:id) { Store.create(title: 'foo', content: 'bar').id }
        run_test!
      end

      response '404', 'store not found' do
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