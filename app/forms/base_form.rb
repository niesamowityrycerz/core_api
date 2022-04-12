class BaseForm < Dry::Validation::Contract
  config.messages.load_paths << 'config/errors.yml'
  config.messages.default_locale = :en

  EMAIL_REGEX = /\A([a-zA-Z0-9\!\#\$\%\&\'\*\-\/\=\?\^\_\`\{\|\}\~\.\-]{1,}(\+[a-z0-9\!\#\$\%\&\'\*\-\/\=\?\^\_\`\{\|\}\~\.\-]+){0,})@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  register_macro(:email_format) do
    key.failure(:email_format) unless EMAIL_REGEX.match?(value)
  end

  register_macro(:unique_email) do
    key.failure(:unique_email) if User.exists?(email: value)
  end

  register_macro(:user_exists) do
    key.failure(:user_exists) unless User.exists?(id: value)
  end
end