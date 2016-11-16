require 'bundler/setup'
require 'capybara'
require 'capybara/dsl'
require 'selenium-webdriver'
require 'capybara/poltergeist'

Capybara.configure do |config|
  config.run_server = false
  config.current_driver = :selenium#:poltergeist
  #config.javascript_driver = :selenium#:poltergeist
  config.app_host = "https://job.rikunabi.com/2017/search/seminar/result/"
  config.default_max_wait_time = 15
end

module Crawler
  class Rikunabi
    include Capybara::DSL

    def start
      puts "start"
      puts
      visit('')
    end

    def succession
      puts "succession"
      #sleep(3)/html/body/div[1]/div[3]/div/div[3]/div[2]/span[7]/a
      puts find(:xpath, "/html/body/div[1]/div[3]/div/div[3]/div[2]/span[7]/a").text
      find(:xpath, "/html/body/div[1]/div[3]/div/div[3]/div[2]/span[7]/a").click
      #all('a').each {|a| puts a[:href]}
      puts "click"
      puts
      #click_link("search-pager02-list-item-inner")
    end

    def wait_for_ajax
      sleep 2
      Timeout.timeout(Capybara.default_max_wait_time) do
        active = page.evaluate_script('jQuery.active')
        until active == 0
          sleep 1
          active = page.evaluate_script('jQuery.active')
        end
      end
    end

  end
end



crawler = Crawler::Rikunabi.new
crawler.start
while true
  crawler.succession
  sleep(1)
end

gets