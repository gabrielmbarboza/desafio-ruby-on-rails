require 'swagger_helper'

describe 'Customers API Documentation' do

  path '/customers' do
    post 'Creates a customer' do
      tags 'Customer'
      consumes 'application/json'
      parameter name: :customer, in: :body, schema: {
        type: :object,
        properties: {
          itr: { type: :string },
        },
        required: [ 'itr' ]
      }

      response '201', 'Customer created' do
        let(:customer) { create(:customer) }
        run_test!
      end

      response '422', 'invalid request' do
        let(:customer) { { itr: nil } }
        run_test!
      end
    end
  end

  path '/customers' do
    get 'Retrieves all customer' do
      tags 'Customer'
      produces 'application/json', 'application/xml'
      
      response 200, 'Customers found' do
        before { create_list(:customer, 3) }
        run_test!
      end
    end
  end

  path '/customers/{id}' do
    parameter name: :id, in: :path, type: :integer

    get 'Retrieves a customer' do
      produces 'application/json'
      parameter name: :customer, in: :body
 
      response '200', 'Customer found' do
        let(:customer1) { create(:customer) }
        let(:id) { customer1.id }
      end
 
      response '404', 'customer not found' do
        let(:id) { -1 }
      end
    end

    patch 'Updates a customer' do
      tags 'Customer'
      consumes 'application/json'
      parameter name: :customer, in: :body
      
      let(:customer2) { create(:customer) }
      let(:id) { customer2.id }
      
      response '200', 'Customer updated' do
        let(:customer) do 
          {
            itr: Faker::IDNumber.brazilian_citizen_number,
          }
        end
        run_test!
      end
    
      response '422', 'invalid request' do
        let(:customer) { { itr: nil } }
        run_test!
      end
    end
  end

  path '/customers/{id}' do
    delete 'Delete a Customer' do
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer
      produces 'application/json'
 
      response '204', 'Destroy the Customer' do
        let(:id) { create(:customer).id }
        run_test!
      end
    end
  end
end