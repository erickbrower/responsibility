module Responsibility
  module ClassMethods
    def before(service)
      begin
        if service.respond_to?(:before)
          if !service.before || service.errors.any?
            handle_failure(service: service)
          end
        end
      rescue FailureError => e
        handle_failure(service: service, error: e)
      end
      service.success?
    end

    def after(service)
      begin
        if service.respond_to?(:after)
          if !service.after || service.errors.any?
            handle_failure(service: service)
          end
        end
      rescue FailureError => e
        handle_failure(service: service, error: e)
      end
      service.success?
    end

    def perform(*args)
      args = {} if args.is_a?(Array)
      service = new(args)
      if before(service)
        begin
          service.perform
          handle_failure(service: service) if service.errors.any?
        rescue FailureError => e
          handle_failure(service: service, error: e)
        end
      end
      if service.success?
        if !after(service) || service.errors.any?
          handle_failure(service: service)
        end
      end
      service
    end

    private
    def handle_failure(service:, error: nil)
      service.instance_variable_set("@success", false)
      service.errors << error.message if error
    end
  end
end
