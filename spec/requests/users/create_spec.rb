require 'rails_helper'

response_schema = Dry::Schema.JSON do
  required(:id).filled(:integer)
  required(:email).filled(:string)
  required(:total_orders_pln).filled(:string)
  required(:total_orders_eur).filled(:string)
  required(:created_at).filled(:date_time)
  required(:updated_at).filled(:date_time)
end

RSpec.describe 'Create user', type: :request do

  context 'when valid params' do

    let(:params) do
      {
        name: Faker::Name.name,
        email: Faker::Internet.email,
        total_orders_pln: rand(0..100000000)
      }
    end

    it 'creates new user' do
      expect {
        post "/api/v1/users", params: params
      }.to change { User.count }.by(1)
      expect(response.status).to eq(201)

      parsed_body = JSON.parse(response.body)
      expect(
        response_schema.call(parsed_body["user"]
      ).success?).to eq(true)
    end
  end

  context 'when invalid params' do
    context 'when name' do

      let(:params) do
        {
          email: Faker::Internet.email,
          total_orders_pln: rand(0..100000000)
        }
      end

      it 'returns error if missing' do
        post "/api/v1/users", params: params
        expect(response.status).to eq(400)

        parsed_body = JSON.parse(response.body)
        expect(parsed_body['errors']).to eq({name: ['is missing']}.as_json)
      end

      it 'returns error if invalid type' do
        params[:name] = ['test']
        post "/api/v1/users", params: params
        expect(response.status).to eq(400)

        parsed_body = JSON.parse(response.body)
        expect(parsed_body['errors']).to eq({name: ['must be a string']}.as_json)
      end

      it 'return error if exceed chars' do
        params[:name] = 'a' * 51
        post "/api/v1/users", params: params
        expect(response.status).to eq(400)

        parsed_body = JSON.parse(response.body)
        expect(parsed_body['errors']).to eq({name: ['size cannot be greater than 50']}.as_json)
      end
    end

    context 'when email' do

      let(:params) do
        {
          name: Faker::Name.name,
          total_orders_pln: rand(0..100000000)
        }
      end

      it 'returns error if missing' do
        post "/api/v1/users", params: params
        expect(response.status).to eq(400)

        parsed_body = JSON.parse(response.body)
        expect(parsed_body['errors']).to eq({email: ['is missing']}.as_json)
      end

      it 'returns error if invalid format' do
        params[:email] = 'test.pl'
        post "/api/v1/users", params: params
        expect(response.status).to eq(400)

        parsed_body = JSON.parse(response.body)
        expect(parsed_body['errors']).to eq({email: ['has invalid format']}.as_json)
      end

      it 'returns error if invalid type' do
        params[:email] = [Faker::Internet.email]
        post "/api/v1/users", params: params
        expect(response.status).to eq(400)

        parsed_body = JSON.parse(response.body)
        expect(parsed_body['errors']).to eq({email: ['must be a string']}.as_json)
      end

      it 'returns error if already taken' do
        used_email = 'test@gmail.com'
        create(:user, email: used_email)

        params[:email] = used_email
        post "/api/v1/users", params: params
        expect(response.status).to eq(400)

        parsed_body = JSON.parse(response.body)
        expect(parsed_body['errors']).to eq({email: ['is already taken']}.as_json)
      end
    end

    context 'when total_orders_pln' do

      let(:params) do
        {
          name: Faker::Name.name,
          email: Faker::Internet.email,
          total_orders_pln: ::User::MIN_TOTAL_ORDERS_PLN - 1
        }
      end

      it 'returns error if less than 0' do
        post "/api/v1/users", params: params
        expect(response.status).to eq(400)

        parsed_body = JSON.parse(response.body)
        expect(parsed_body['errors']).to eq({total_orders_pln: ['must be greater than or equal to 0.0']}.as_json)
      end

      it 'returns error if exceeded 100000000' do
        params[:total_orders_pln] = ::User::MAX_TOTAL_ORDERS_PLN + 1

        post "/api/v1/users", params: params
        expect(response.status).to eq(400)

        parsed_body = JSON.parse(response.body)
        expect(parsed_body['errors']).to eq({total_orders_pln: ['must be less than or equal to 100000000.0']}.as_json)
      end

      it 'returns error if invalid type' do
        params[:total_orders_pln] = :value

        post "/api/v1/users", params: params
        expect(response.status).to eq(400)

        parsed_body = JSON.parse(response.body)
        expect(parsed_body['errors']).to eq({total_orders_pln: ['must be a float']}.as_json)
      end
    end
  end

end