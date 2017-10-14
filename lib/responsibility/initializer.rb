module Responsibility
  module Initializer
    def initialize(args)
      args[:errors] = []
      args.each do |key, val|
        self.class.send(:attr_accessor, key)
        instance_variable_set("@#{key}", val)
      end
      self.class.send(:attr_reader, :success)
      instance_variable_set("@success", true)
    end
  end
end
