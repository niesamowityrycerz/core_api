module UserForm
  class Create < BaseForm

    params do
      required(:name).filled(:string, max_size?: 50)
      required(:email).filled(:string)
      optional(:total_orders_pln).maybe(:integer, gteq?: User::MIN_TOTAL_ORDERS_PLN, lteq?: User::MAX_TOTAL_ORDERS_PLN)
    end

    rule(:email).validate(:email_format)
    rule(:email).validate(:unique_email)
  end
end