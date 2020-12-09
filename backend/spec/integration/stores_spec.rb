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
          owner: { type: :string },
        },
        required: [ 'name', 'owner' ]
      }

      response '201', 'Store created' do
        let(:store) { create(:store) }
        run_test!
      end

      response '422', 'invalid request' do
        let(:store) { { name: nil } }
        run_test!
      end
    end
  end

  path '/stores' do
    get 'Retrieves all store' do
      tags 'Store'
      produces 'application/json', 'application/xml'
      
      response 200, 'Stores found' do
        before { create_list(:store, 3) }
        run_test!
      end
    end
  end

  path '/stores/{id}' do
    parameter name: :id, in: :path, type: :integer

    get 'Retrieves a store type' do
      produces 'application/json'
      parameter name: :store, in: :body
 
      response '200', 'Store found' do
        let(:store1) { create(:store) }
        let(:id) { store1.id }
      end
 
      response '404', 'store not found' do
        let(:id) { -1 }
      end
    end

    patch 'Updates a store' do
      tags 'Store'
      consumes 'application/json'
      parameter name: :store, in: :body
      
      let(:store2) { create(:store) }
      let(:id) { store2.id }
      
      response '200', 'Store updated' do
        let(:store) do 
          {
            name: Faker::Company.name,
            owner: Faker::Name.name
          }
        end
        run_test!
      end
    
      response '422', 'invalid request' do
        let(:store) { { name: nil } }
        run_test!
      end
    end
  end

  path '/stores/{id}' do
    delete 'Delete a Store' do
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer
      produces 'application/json'
 
      response '204', 'Destroy the Store' do
        let(:id) { create(:store).id }
        run_test!
      end
    end
  end
end