RSpec.configure do |c|
  c.mock_with :rspec
  c.hiera_config = File.expand_path(File.join(__FILE__, '../fixtures/hiera.yaml'))

  c.after(:suite) do
    RSpec::Puppet::Coverage.report!
  end
end
