# frozen_string_literal: true

require "selenium-webdriver"
require "uri"

module BookmeterExporter
  class Crawler
    def initialize(email, password)
      @email = email
      @password = password
      @bookmeter_root = URI.parse("https://bookmeter.com/")
    end

    def crawl
      start_webdriver
      login
      # More codes goes here

      puts "crawling end"
    end

    private

    def start_webdriver
      puts "Starting Chrome..."
      @driver = Selenium::WebDriver.for :chrome
      @wait = Selenium::WebDriver::Wait.new(timeout: 5)
    end

    def login
      @driver.get URI.join(@bookmeter_root, "/login")
      @driver.find_element(:id, "session_email_address").send_keys @email
      @driver.find_element(:id, "session_password").send_keys @password
      @driver.find_element(:css, "form[action='/login'] button[type=submit]").click
      @wait.until do
        @driver.current_url == URI.join(@bookmeter_root, "/home").to_s
      end
    end
  end
end
