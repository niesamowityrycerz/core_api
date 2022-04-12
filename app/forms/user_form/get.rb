module UserForm
  class Get < BaseForm

    params do
      required(:id).filled(:integer, gt?: 0)
    end

    rule(:id).validate(:user_exists)
  end
end