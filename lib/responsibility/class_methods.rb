module Responsibility
  module ClassMethods
    def before(obj)
      if obj.respond_to?(:before)
        result = obj.before
        if obj.errors.any?
          obj.instance_variable_set("@success", false)
        else
          obj.instance_variable_set("@success", !!result)
        end
      end
    end

    def after(obj)
      if obj.respond_to?(:after)
        result = obj.after
        if obj.errors.any?
          obj.instance_variable_set("@success", false)
        else
          obj.instance_variable_set("@success", !!result)
        end
      end
    end

    def perform(*args)
      args = {} if args.is_a?(Array)
      service = new(args)
      before(service)
      if service.success?
        service.perform
      end
      if service.errors.any?
        service.instance_variable_set("@success", false)
      end
      if service.success?
        after(service)
      end
      service
    end
  end
end
