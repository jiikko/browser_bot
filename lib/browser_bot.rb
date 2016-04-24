require 'yaml'
require 'capybara/dsl'
require 'pry'

module BrowsserBot
  CONDFIG_FILE = 'config.yml'

  def self.run(params)
    load_config(params)
    case params['j']
    when 'wantedly_click_support_link'
      require 'browser_bot/job/wantedly/click_support_link'
      browser_init(params['headless'])
      BrowsserBot::Job::Wantedly::ClickSupportLink.new(@config).run
    else
      puts 'not found job_name'
      exit 1
    end
  end

  private

  def self.load_config(params)
    config_file = params['config_file'] || CONDFIG_FILE
    if File.exists?(config_file)
      @config = YAML.load_file(config_file)
    else
      puts 'not found condfig_path'
      exit 1
    end
  end

  def self.browser_init(headless)
    if headless
      require 'capybara/poltergeist'
      # https://github.com/teampoltergeist/poltergeist
      Capybara.register_driver :poltergeist do |app|
        Capybara::Poltergeist::Driver.new(app, {
          js_errors: false,
          timeout: 120,
        })
      end
      Capybara.javascript_driver = :poltergeist
      Capybara.current_driver = :poltergeist
      extend Capybara::DSL
      page.driver.headers = { 'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; WOW64; rv:42.0) Gecko/20100101 Firefox/42.0', }
    else
      browser_name = :firefox
      Capybara.run_server = false
      Capybara.register_driver(browser_name) do |app|
        Capybara::Selenium::Driver.new(app, {
          browser: browser_name,
        })
      end
      Capybara.current_driver = browser_name
    end
    Capybara.reset_sessions!
  end
end
