module Responsibility
  module Initializer
    def initialize(args)
      args.each do |key, val|
        self.class.send(:attr_accessor, key)
        instance_variable_set("@#{key}", val)
      end
      self.class.send(:attr_reader, :success)
      instance_variable_set("@success", true)
      self.class.send(:attr_reader, :errors)
      instance_variable_set("@errors", [])
    end
  end
end
