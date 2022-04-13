module UserForm
  class Create < BaseForm

    params do
      required(:name).filled(:string, max_size?: 50)
      required(:email).filled(:string)
      optional(:total_orders_pln).maybe(:float, gteq?: User::MIN_TOTAL_ORDERS_PLN, lteq?: User::MAX_TOTAL_ORDERS_PLN)
    end

    rule(:email) do
      key.failure(:email_format) unless BaseForm::EMAIL_REGEX.match?(value)
    end

    rule(:email) do
      key.failure(:unique_email) if User.exists?(email: value)
    end
  end
end