class BaseForm < Dry::Validation::Contract
  config.messages.load_paths << 'config/errors.yml'
  config.messages.default_locale = :en

  EMAIL_REGEX = /\A([a-zA-Z0-9\!\#\$\%\&\'\*\-\/\=\?\^\_\`\{\|\}\~\.\-]{1,}(\+[a-z0-9\!\#\$\%\&\'\*\-\/\=\?\^\_\`\{\|\}\~\.\-]+){0,})@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
end