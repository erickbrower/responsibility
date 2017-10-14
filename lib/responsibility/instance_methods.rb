module Responsibility
  module InstanceMethods
    def success?
      success == true
    end

    def failure?
      success == false
    end

    def fail!
      success = false
    end

    def succeed!
      success = true
    end
  end
end
