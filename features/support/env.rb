require 'cucumber'
require 'dotenv/load'
require 'rubocop-rails'
require 'rspec/expectations'
require 'selenium-webdriver'
require 'capybara/cucumber'
require 'securerandom'
require 'site_prism'
require 'pry'
require 'gmail'
require 'airborne'

require 'yaml'
require 'json'
require 'uuid'
require 'require_all'

STRINGS = YAML.load_file("#{Dir.pwd}/features/support/fixtures/string_values.yml")
BROWSER = ENV['browser'] || 'chrome' # Setting Chrome by default
RESOLUTION = ENV['resolution'] || 'desktop-large' # Setting desktop-large resolution by default

require_all 'page_objects/pages'

def chrome?
  BROWSER == 'chrome'
end

def firefox?
  BROWSER == 'firefox'
end

def safari?
  BROWSER == 'safari'
end

def browser_not_defined_error
  raise '[31m' + 'Browser to run is not specified. Please run your tests with: ' \
            'browser=chrome or browser=firefox or browser=safari' + '[0m'
end

# setting Capybara driver
def options
  Selenium::WebDriver::Chrome::Options.new(args: %w[window-size=1800,1000])
end

Capybara.default_driver = :selenium
Capybara.register_driver :selenium do |app|
  if chrome?
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
  elsif firefox?
    Capybara::Selenium::Driver.new(app, browser: :firefox)
  elsif safari?
    Capybara::Selenium::Driver.new(app, browser: :safari)
  else
    browser_not_defined_error
  end
end

at_exit do
  if ENV['TEST_RAIL_PASS']
    @test_rail = TestRail::APIClient.new
    test_run_name = 'NewsAppServer QA EnvRun'
    test_run_id = @test_rail.add_run('365', test_run_name)
    results = JSON.parse(File.read(Dir.pwd + '/data/test_results.json'))['results']
    @test_rail.add_results_for_cases(test_run_id, results)
  end
end

