require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/transactions", type: :request do
  let(:store) { create(:store) }
  
  let(:customer) { create(:customer) }
  
  let(:transaction_type) { create(:transaction_type) }

  let(:valid_attributes) {
    attributes_for(:transaction, 
      store_id: store.id, customer_id: customer.id, 
      transaction_type_id: transaction_type.id)
  }

  let(:invalid_attributes) {
    attributes_for(:transaction, amount: nil)
  }

  # This should return the minimal set of values that should be in the headers
  # in order to pass any filters (e.g. authentication) defined in
  # TransactionsController, or in your router and rack
  # middleware. Be sure to keep this updated too.
  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      Transaction.create! valid_attributes
      
      get "#{transactions_url}?store_id=#{store.id}", headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      transaction = Transaction.create! valid_attributes
      get transaction_url(transaction), as: :json
      puts response
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Transaction" do
        expect {
          post transactions_url,
               params: { transaction: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Transaction, :count).by(1)
      end

      it "renders a JSON response with the new transaction" do
        post transactions_url,
             params: { transaction: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Transaction" do
        expect {
          post transactions_url,
               params: { transaction: invalid_attributes }, as: :json
        }.to change(Transaction, :count).by(0)
      end

      it "renders a JSON response with errors for the new transaction" do
        post transactions_url,
             params: { transaction: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        attributes_for(:transaction, 
          store_id: store.id, customer_id: customer.id, 
          transaction_type_id: transaction_type.id)
      }

      it "updates the requested transaction" do
        transaction = Transaction.create! valid_attributes
        patch transaction_url(transaction),
              params: { transaction: new_attributes }, headers: valid_headers, as: :json
        transaction.reload
        expect(transaction.amount.to_f).to eq(new_attributes[:amount].to_f)
        expect(transaction.performed_at).to eq(new_attributes[:performed_at])
        expect(transaction.store.id).to eq(new_attributes[:store_id])
        expect(transaction.customer.id).to eq(new_attributes[:customer_id])
        expect(transaction.transaction_type.id).to eq(new_attributes[:transaction_type_id])
      end

      it "renders a JSON response with the transaction" do
        transaction = Transaction.create! valid_attributes
        patch transaction_url(transaction),
              params: { transaction: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the transaction" do
        transaction = Transaction.create! valid_attributes
        patch transaction_url(transaction),
              params: { transaction: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested transaction" do
      transaction = Transaction.create! valid_attributes
      expect {
        delete transaction_url(transaction), headers: valid_headers, as: :json
      }.to change(Transaction, :count).by(-1)
    end
  end
end
