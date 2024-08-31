# frozen_string_literal: true

require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock # or :faraday
  config.configure_rspec_metadata!
  # config.ignore_localhost = true
  # config.debug_logger = $stdout
  config.default_cassette_options = { match_requests_on: %i[method uri body] }
  # Optional configuration
  # config.default_cassette_options = { :record => :new_episodes }
end
