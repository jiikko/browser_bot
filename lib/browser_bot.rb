require 'yaml'
require 'capybara/dsl'
require 'pry'

module BrowsserBot
  CONDFIG_FILE = 'config.yml'

  def self.run
    extend Capybara::DSL
    browser_init
    # ここにかく
    #
    #
    visit 'http://google.com'
    sleep 10
  end

  private

  def self.browser_init
    browser_name = :chrome
    Capybara.run_server = false
    Capybara.register_driver(browser_name) do |app|
      Capybara::Selenium::Driver.new(app, {
        browser: browser_name, # run firefox if blank or :firefox
      })
    end
    Capybara.current_driver = browser_name
  end
  Capybara.reset_sessions!
end
