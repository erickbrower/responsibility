require 'responsibility'

class MySuccessfulService; include Responsibility; end;

class MyErrorsService
  include Responsibility

  def perform
    errors << "This is an example error!"
  end
end

class MyFailingService
  include Responsibility

  def perform
    fail!(message: "Fail whale")
  end
end
