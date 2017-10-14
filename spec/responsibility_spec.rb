RSpec.describe Responsibility do
  it 'has a version number' do
    expect(Responsibility::VERSION).not_to be nil
  end
end

RSpec.describe Responsibility::ServiceObject do
  it 'calls before, perform, and after' do
    allow_any_instance_of(Responsibility::ServiceObject)
      .to receive(:before)
      .and_return(true)
    allow_any_instance_of(Responsibility::ServiceObject)
      .to receive(:after)
      .and_return(true)
    allow_any_instance_of(Responsibility::ServiceObject)
      .to receive(:perform)

    expect_any_instance_of(Responsibility::ServiceObject)
      .to receive(:before)
    expect_any_instance_of(Responsibility::ServiceObject)
      .to receive(:perform)
    expect_any_instance_of(Responsibility::ServiceObject)
      .to receive(:after)
    service = Responsibility::ServiceObject.perform
    expect(service).to be_success
  end

  it "doesn't call perform if before returns false" do
    allow_any_instance_of(Responsibility::ServiceObject)
      .to receive(:before)
      .and_return(false)
    allow_any_instance_of(Responsibility::ServiceObject)
      .to receive(:perform)

    expect_any_instance_of(Responsibility::ServiceObject)
      .to receive(:before)
      .and_return(false)
    expect_any_instance_of(Responsibility::ServiceObject)
      .not_to receive(:perform)

    service = Responsibility::ServiceObject.perform
    expect(service).to be_failure
  end

  it "creates attr_accessors for any arguments passed to initialize" do
    service = Responsibility::ServiceObject.new(one: 1, two: 2)
    expect(service).to respond_to(:one)
    expect(service).to respond_to(:two)
    expect(service.one).to eq(1)
    expect(service.two).to eq(2)
  end
end
