require 'rails_helper'

response_schema = Dry::Schema.JSON do
  required(:users).filled(:array).each do
    hash do
      required(:id).filled(:integer)
      required(:email).filled(:string)
      required(:total_orders_pln).filled(:string)
      required(:total_orders_eur).filled(:string)
      required(:created_at).filled(:date_time)
      required(:updated_at).filled(:date_time)
    end
  end
end

RSpec.describe 'List all user', type: :request do

  context 'when at least one user' do

    let(:number_of_users) { rand(1..10) }
    let!(:users)          { create_list(:user, number_of_users) }

    it 'returns all users' do
      get "/api/v1/users"
      expect(response.status).to eq(200)
      parsed_body = JSON.parse(response.body)

      expect(parsed_body['users'].size).to eq(number_of_users)
      expect(
        response_schema.call(parsed_body).success?
      ).to eq(true)
    end
  end

  context 'when no users' do
    it 'returns friendly info' do
      get "/api/v1/users"
      expect(response.status).to eq(200)
      parsed_body = JSON.parse(response.body)

      expect(parsed_body['users']).to eq("There are no users.Go ahead and create one!")
    end
  end
end