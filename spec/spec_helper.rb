# frozen_string_literal: true

require "portkey"
require "vcr"

require "dotenv"

Dotenv.load(".env.local")

VCR.configure do |config|
  config.cassette_library_dir = "spec/cassettes"
  config.hook_into :faraday
  config.configure_rspec_metadata!
  config.filter_sensitive_data("PORTKEY_API_KEY") { ENV.fetch("PORTKEY_API_KEY") }
  config.filter_sensitive_data("PORTKEY_VIRTUAL_KEY") { ENV.fetch("PORTKEY_VIRTUAL_KEY") }
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

