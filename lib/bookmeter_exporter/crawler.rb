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
      go_read_books
      fetch_read_books_content
      # More codes goes here

      puts "crawling end"
    end

    private

    def start_webdriver
      puts "Starting Chrome..."
      @driver = Selenium::WebDriver.for :chrome
      @wait = Selenium::WebDriver::Wait.new(timeout: 10)
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

    def go_read_books
      @driver.find_element(:css, "ul.userdata-nav li").click
      @wait.until do
        %r{/books/read$}.match(@driver.current_url)
        sleep 3
      end
    end

    def fetch_read_books_content
      @driver.find_elements(:css, ".book-list--grid ul.book-list__group").each do |ul|
        ul.find_elements(:tag_name, "li").each do |li|
          li.find_element(:css, ".book__thumbnail").click
          @wait.until do
            %r{/books/[0-9]+$}.match(@driver.current_url)
            sleep 3
          end
          amazon_url = @driver.find_element(:css, ".sidebar__group .group__image a").attribute("href")
          read_date = @driver.find_element(:css, ".read-book__date").text
          review_text = @driver.find_element(:css, ".read-book__content").text

          puts amazon_url, read_date, review_text

          @driver.navigate.back
        end
      end
    end
  end
end
