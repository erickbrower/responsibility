require "responsibility/version"
require "responsibility/initializer"
require "responsibility/instance_methods"
require "responsibility/class_methods"

module Responsibility
  def self.included(base)
    base.send(:prepend, Initializer)
    base.include(InstanceMethods)
    base.extend(ClassMethods)
  end
end
