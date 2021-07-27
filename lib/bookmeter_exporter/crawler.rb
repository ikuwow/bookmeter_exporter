# frozen_string_literal: true

require "selenium-webdriver"

module BookmeterExporter
  class Crawler
    def initialize(email, password)
      @email = email
      @password = password
    end

    def crawl
      puts "crawling"
      driver = Selenium::WebDriver.for :chrome
      driver.get "https://bookmeter.com/login"
      puts "crawling end"
    end
  end
end
