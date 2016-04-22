require 'yaml'
require 'capybara/dsl'
require 'selenium-webdriver'
require 'jobs/wantedly/click_support_link'

module BrowsserBot
  CONDFIG_PATH = 'config.yml'

  attr_reader :config

  def self.run(job_name)
    load_config
    case job_name
    when 'wantedly_click_support_link'
      BrowsserBot::Wantedly::ClickSupportLink.new(self).run
    else
      puts 'not found job_name'
      exit 1
    end
  end

  private

  def load_config
    if File.exists?(CONDFIG_PATH)
      @config = YAML.load(CONDFIG_PATH)
    else
      puts 'not found condfig_path'
      exit 1
    end
  end
end
