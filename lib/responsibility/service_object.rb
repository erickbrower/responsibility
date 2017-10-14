require 'pry'

module Responsibility
  class ServiceObject
    def initialize(args)
      args[:errors] = []
      args[:success] = true
      args.each do |key, val|
        self.class.send(:attr_accessor, key)
        instance_variable_set("@#{key}", val)
      end
    end

    def self.before(obj)
      if obj.respond_to?(:before)
        result = obj.before
        obj.success = !!result
      end
    end

    def self.after(obj)
      if obj.respond_to?(:after)
        result = obj.after
        obj.success = !!result
      end
    end

    def self.perform(*args)
      args = {} if args.is_a?(Array)
      service = new(args)
      before(service)
      if service.success?
        service.perform
      end
      if service.success?
        after(service)
      end
      service
    end

    def success?
      success == true
    end

    def failure?
      success == false
    end

    def fail!
      success = false
    end

    def success!
      success = true
    end
  end
end
