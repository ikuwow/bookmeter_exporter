# frozen_string_literal: true

require "selenium-webdriver"
require "uri"
require "cgi"

require_relative "books"

module BookmeterExporter
  class Crawler
    def initialize(email, password)
      @email = email
      @password = password
      @root_url = URI("https://bookmeter.com/")
      @user_id = nil
    end

    def crawl
      start_webdriver
      login
      book_urls = collect_book_urls
      fetch_books(book_urls)
    end

    private

    def start_webdriver
      puts "Starting Chrome..."
      @driver = Selenium::WebDriver.for :chrome
      @wait = Selenium::WebDriver::Wait.new(timeout: 10)
    end

    def login
      @driver.get @root_url.merge("/login")
      @driver.find_element(:id, "session_email_address").send_keys @email
      @driver.find_element(:id, "session_password").send_keys @password
      @driver.find_element(:css, "form[action='/login'] button[type=submit]").click
      @wait.until { @driver.current_url == @root_url.merge("/home").to_s }

      puts "Login success."

      @user_id = @driver.find_element(:css, ".personal-account__data__link").attribute("href")[%r{/([0-9]+)$}, 1]
    end

    def fetch_books(book_urls)
      books = Books.new
      book_urls.each do |url|
        books << fetch_book(url)
      end
      books
    end

    def collect_book_urls
      go_read_books

      last_page_url = @driver.find_element(:css, "ul.bm-pagination").find_element(:link_text, "最後").attribute("href")
      last_page = CGI.parse(URI.parse(last_page_url).query)["page"].shift.to_i

      urls = []
      (1..last_page).each do |page|
        page_url = @root_url.merge("/users/#{@user_id}/books/read?page=#{page}")
        @driver.get page_url

        book_list_css_selector = ".book-list--grid ul.book-list__group"
        @wait.until { @driver.current_url == page_url.to_s }
        @driver.find_elements(:css, book_list_css_selector).each do |ul|
          ul.find_elements(:css, "li .detail__title").each do |li|
            urls << li.find_element(:tag_name, "a").attribute("href")
          end
        end
      end

      urls
    end

    def go_read_books
      read_books_url = @root_url.merge("/users/#{@user_id}/books/read")
      @driver.get read_books_url
      @wait.until { sleep 3 }
    end

    def fetch_book(url)
      @driver.get url
      @wait.until do
        %r{/books/[0-9]+$}.match(@driver.current_url)
      end

      book_asin = @driver.find_element(:css, ".sidebar__group .group__image a").attribute("href")
                         .gsub(%r{https://www.amazon.co.jp/dp/product/(.+)/.*}, '\1')
      read_date = @driver.find_element(:css, ".read-book__date").text
      review_text = @driver.find_element(:css, ".read-book__content").text

      Book.new(book_asin, read_date, review_text)
    end
  end
end
