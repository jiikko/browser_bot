require 'yaml'
require 'capybara/dsl'
require 'pry'

module BrowsserBot
  CONDFIG_FILE = 'config.yml'

  def self.run(params)
    extend Capybara::DSL
    # ここにかく
  end

  private

  def self.browser_init(headless)
    if headless
      require 'capybara/poltergeist'
      # https://github.com/teampoltergeist/poltergeist
      Capybara.javascript_driver = :poltergeist
      Capybara.current_driver = :poltergeist
      Capybara.register_driver :poltergeist do |app|
        Capybara::Poltergeist::Driver.new(app, {
          js_errors: false,
        })
      end
    else
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
end
