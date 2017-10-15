module Responsibility
  module InstanceMethods
    def success?
      success == true
    end

    def failure?
      success == false
    end

    def fail!(message: nil)
      raise FailureError.new(message)
    end
  end
end
