require 'rails_helper'

response_schema = Dry::Schema.JSON do
  required(:id).filled(:integer)
  required(:email).filled(:string)
  required(:total_orders_pln).filled(:string)
  required(:total_orders_eur).filled(:string)
  required(:created_at).filled(:date_time)
  required(:updated_at).filled(:date_time)
end

RSpec.describe 'Get user by id', type: :request do

  context 'when user exists' do

    let!(:user)  { create(:user) }

    it 'returns user' do
      get "/api/v1/users/#{user.id}"
      expect(response.status).to eq(200)
      parsed_body = JSON.parse(response.body)
      expect(
        response_schema.call(parsed_body["user"]
      ).success?).to eq(true)
    end
  end

  context 'when user does NOT exist' do

    let(:invalid_id)   { rand(100..1000) }

    it 'returns error' do
      get "/api/v1/users/#{invalid_id}"
      expect(response.status).to eq(400)
      parsed_body = JSON.parse(response.body)

      expect(parsed_body['errors']).to eq({user: ["does not exist"]}.as_json)
    end
  end
end