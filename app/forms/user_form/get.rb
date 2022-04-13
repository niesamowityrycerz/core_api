module UserForm
  class Get < BaseForm

    params do
      required(:id).filled(:integer, gt?: 0)
    end

    rule(:id) do
      key(:user).failure(:user_exists) unless User.exists?(id: value)
    end
  end
end