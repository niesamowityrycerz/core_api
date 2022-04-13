module CoreApi
  module Users
    class Create < BaseService

      def initialize(input_params)
        @input_params = input_params
      end

      attr_reader :input_params

      def call
        form = ::UserForm::Create.new.call(input_params)
        return validation_errors(form) if form.failure?

        params = form.to_h
        retrieved_user = create_user(params)
        { user: retrieved_user }
      end

      private

      def create_user(user_params)
        unless user_params.key?(:total_orders_pln)
          random_total_orders_pln = rand(User::MIN_TOTAL_ORDERS_PLN..User::MAX_TOTAL_ORDERS_PLN)
          user_params.merge!(total_orders_pln: random_total_orders_pln)
        end

        User.create!(user_params)
      end
    end
  end
end