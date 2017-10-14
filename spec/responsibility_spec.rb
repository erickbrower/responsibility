RSpec.describe Responsibility do
  it 'has a version number' do
    expect(Responsibility::VERSION).not_to be nil
  end
end

class MyExampleService; include Responsibility; end;

RSpec.describe MyExampleService do
  it 'calls before, perform, and after' do
    allow_any_instance_of(MyExampleService)
      .to receive(:before)
      .and_return(true)
    allow_any_instance_of(MyExampleService)
      .to receive(:after)
      .and_return(true)
    allow_any_instance_of(MyExampleService)
      .to receive(:perform)

    expect_any_instance_of(MyExampleService)
      .to receive(:before)
    expect_any_instance_of(MyExampleService)
      .to receive(:perform)
    expect_any_instance_of(MyExampleService)
      .to receive(:after)
    service = MyExampleService.perform
    expect(service).to be_success
  end

  it "doesn't call perform if before returns false" do
    allow_any_instance_of(MyExampleService)
      .to receive(:before)
      .and_return(false)
    allow_any_instance_of(MyExampleService)
      .to receive(:perform)

    expect_any_instance_of(MyExampleService)
      .to receive(:before)
      .and_return(false)
    expect_any_instance_of(MyExampleService)
      .not_to receive(:perform)

    service = MyExampleService.perform
    expect(service).to be_failure
  end

  it "creates attr_accessors for any arguments passed to initialize" do
    service = MyExampleService.new(one: 1, two: 2)
    expect(service).to respond_to(:one)
    expect(service).to respond_to(:two)
    expect(service.one).to eq(1)
    expect(service.two).to eq(2)
  end


end

class MyErrorsService
  include Responsibility

  def perform
    errors << "This is an example error!"
  end
end

RSpec.describe MyErrorsService do
  it "fails if any errors are set" do
    service = MyErrorsService.perform
    expect(service).to be_failure
  end
end
