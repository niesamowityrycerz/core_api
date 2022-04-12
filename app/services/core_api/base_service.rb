module CoreApi

  ValidationError = Class.new(StandardError)

  class BaseService

    def validation_errors(form)
      { errors: form.errors.to_h, status: 400 }
    end

  end
end