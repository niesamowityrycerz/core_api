module CoreApi
  module Users
    class Get < BaseService

      def initialize(input_params)
        @input_params = input_params
      end

      attr_reader :input_params

      def call
        form = ::UserForm::Get.new.call(input_params)
        return validation_errors(form) if form.failure?

        params = form.to_h
        get_user(params)
      end

      private

      def get_user(params)
        User.find_by(id: params[:id])
      end

    end
  end
end