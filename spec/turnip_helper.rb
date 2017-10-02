require 'capybara/dsl'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'turnip'
require 'turnip/capybara'
require 'yaml'

ENV["RAILS_ROOT"] ||= File.expand_path(File.dirname(__FILE__) + '/dummy')

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, window_size: [1280, 1024], :js_errors => false, :default_max_wait_time => 30, :timeout => 60)
end

Capybara.register_driver :mobile do |app|
  Capybara::Poltergeist::Driver.new(app,
    :headers => {'HTTP_USER_AGENT' => 'KDDI-CA39 UP.Browser/6.2.0.13.1.5 (GUI) MMP/2.0'})
end

Capybara.register_driver :pc do |app|
  Capybara::Poltergeist::Driver.new(app, browser: :remote, :inspector => true,
    :headers => {'HTTP_USER_AGENT' => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.1:9515 Safari/537.36'})
end

Capybara.configure do |config|
  config.default_driver = :poltergeist
  config.javascript_driver = :poltergeist
  config.ignore_hidden_elements = true
  config.default_max_wait_time = 30

  setting = YAML.load_file("/var/www/zomeki_auto_test_files/config.yml")
  config.app_host = setting["config"]["app_host"]
end

RSpec.configure do |config|
  config.before do |example|
    puts
    puts '::' + example.metadata[:example_group][:description]
  end
end

Dir.glob("/var/www/zomeki_auto_test_files/spec/steps/*steps.rb") { |f| load f, true }
