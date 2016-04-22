class BrowsserBot::Job::Wantedly::ClickSupportLink
  def initialize(browser_bot)
    @config = browser_bot.config
  end

  def run
    project_elements.each do |project_element|
      Project.new(project_element).click_support_link
    end
  end

  private

  def project_elements
  end

  class Project
    def initialize(project_element)
    end

    def click_support_link
    end
  end
end
