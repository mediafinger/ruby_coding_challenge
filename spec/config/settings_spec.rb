RSpec.describe Settings do
  before do
    ENV["SOME_TEST_ENV_VAR"] = "settings_test"
    described_class.register :some_test_env_var

    described_class.register :some_test_default,     default: "default value"

    described_class.register :some_test_bootup_time, default: Time.now
    described_class.register :some_test_false,       default: false
    described_class.register :some_test_true,        default: true
    described_class.register :some_test_number,      default: 5
    described_class.register :some_test_string,      default: "This is a test"
    described_class.register :some_test_host_url,    default: "http://example.com"
  end

  it "tests some current setup values", :aggregate_failures do
    expect(described_class.some_test_env_var).to     eq("settings_test")
    expect(described_class.some_test_default).to     eq("default value")
    expect(described_class.some_test_bootup_time).to be_an_instance_of(Time)
    expect(described_class.some_test_false).to       eq(false)
    expect(described_class.some_test_true).to        eq(true)
    expect(described_class.some_test_number).to      eq(5)
    expect(described_class.some_test_string).to      eq("This is a test")
    expect(described_class.some_test_host_url).to    eq("http://example.com")

    expect(described_class.some_test_default).to     be_a(String)
    expect(described_class.some_test_bootup_time).to be_a(Time)
    expect(described_class.some_test_false).to       be_a(FalseClass)
    expect(described_class.some_test_true).to        be_a(TrueClass)
    expect(described_class.some_test_number).to      be_a(Integer)

    expect(described_class.is?(:some_test_false, false)).to   eq true
    expect(described_class.is?(:some_test_false, "false")).to eq true
    expect(described_class.is?(:some_test_true, true)).to     eq true
    expect(described_class.is?(:some_test_true, "true")).to   eq true
    expect(described_class.is?(:some_test_number, 5)).to      eq true
    expect(described_class.is?(:some_test_number, "5")).to    eq true
  end
end
