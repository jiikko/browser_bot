module BrowsserBot
  module Job
    module Wantedly
      class ClickSupportLink
        include Capybara::DSL

        PROTCOL = 'https'
        HOST = 'www.wantedly.com'

        def initialize(config)
          @config = config
        end

        def run
          login!
          while project_element do
            project_element.click
            click_button('応援する')
          end
        end

        private

        def login!
          visit url('/user/sign_in')
          fill_in 'user_email', with: @config['wantedly']['email']
          fill_in 'user_password', with: @config['wantedly']['password']
          click_button('ログイン')
        end

        def url(path=nil)
          "#{PROTCOL}://#{HOST}#{path if path}"
        end

        def project_element
          # エレメントnot foundになって監視がめんどいので都度visit
          visit url('/companies/actindi/projects')
          all('.project-support-link').first
        end
      end
    end
  end
end
