require_relative "support/test_services"

RSpec.describe Responsibility do
  it 'has a version number' do
    expect(Responsibility::VERSION).not_to be nil
  end
end

RSpec.describe MySuccessfulService do
  it 'calls before, perform, and after' do
    allow_any_instance_of(described_class)
      .to receive(:before)
      .and_return(true)
    allow_any_instance_of(described_class)
      .to receive(:after)
      .and_return(true)
    allow_any_instance_of(described_class)
      .to receive(:perform)

    expect_any_instance_of(described_class)
      .to receive(:before)
    expect_any_instance_of(described_class)
      .to receive(:perform)
    expect_any_instance_of(described_class)
      .to receive(:after)
    service = described_class.perform
    expect(service).to be_success
  end

  it "doesn't call perform if before returns false" do
    allow_any_instance_of(described_class)
      .to receive(:before)
      .and_return(false)
    allow_any_instance_of(described_class)
      .to receive(:perform)

    expect_any_instance_of(described_class)
      .to receive(:before)
      .and_return(false)
    expect_any_instance_of(described_class)
      .not_to receive(:perform)

    service = described_class.perform
    expect(service).to be_failure
  end

  it "creates attr_accessors for any arguments passed to initialize" do
    service = described_class.new(one: 1, two: 2)
    expect(service).to respond_to(:one)
    expect(service).to respond_to(:two)
    expect(service.one).to eq(1)
    expect(service.two).to eq(2)
  end
end

RSpec.describe MyErrorsService do
  it "fails if any errors are set" do
    service = described_class.perform
    expect(service).to be_failure
  end
end

RSpec.describe MyFailingService do
  it "sets success to false and includes error message when calling #fail!" do
    service = described_class.perform
    expect(service).to be_failure
    expect(service.errors).to include("Fail whale")
  end
end
