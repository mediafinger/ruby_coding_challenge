# frozen_string_literal: true

# lograge config, check README for more info: https://github.com/roidrage/lograge
Rails.application.configure do
  config.lograge.enabled = true

  config.lograge.base_controller_class = ["ActionController::Base"]

  config.lograge.formatter = Lograge::Formatters::KeyValue.new

  config.lograge.custom_payload do |controller|
    {
      # host: controller.request.host, # when added to payload in application_controller
      # trace_id: controller.request.host, # when added to payload in application_controller
      user_id: controller.current_user&.id,
    }
  end

  config.lograge.custom_options = lambda do |event|
    # exclusions = %w(controller action format id) # this is not the same as filter_parameters
    {
      # params: event.payload[:params].except(*exclusions),

      exception: event.payload[:exception], # ["ExceptionClass", "the message"]
      # exception_object: event.payload[:exception_object], # the exception instance
    }
  end
end
