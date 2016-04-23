require 'yaml'
require 'capybara/dsl'
require 'pry'

module BrowsserBot
  CONDFIG_PATH = 'config.yml'

  def self.run(job_name)
    load_config
    case job_name
    when 'wantedly_click_support_link'
      require 'browser_bot/job/wantedly/click_support_link'
      browser_init
      BrowsserBot::Job::Wantedly::ClickSupportLink.new(@config).run
    else
      puts 'not found job_name'
      exit 1
    end
  end

  private

  def self.load_config
    if File.exists?(CONDFIG_PATH)
      @config = YAML.load_file(CONDFIG_PATH)
    else
      puts 'not found condfig_path'
      exit 1
    end
  end

  def self.browser_init
    browser_name = :chrome
    Capybara.run_server = false
    Capybara.register_driver(browser_name) do |app|
      Capybara::Selenium::Driver.new(app, {
        browser: browser_name,
      })
    end
    Capybara.current_driver = browser_name
    Capybara.reset_sessions!
  end
end
