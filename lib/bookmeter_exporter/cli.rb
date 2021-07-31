# frozen_string_literal: true

require "thor"
require "csv"
require_relative "crawler"
require_relative "version"

module BookmeterExporter
  class CLI < Thor
    class << self
      def exit_on_failure?
        true
      end
    end

    desc "export EMAIL", "This command exports all read books of an account as CSV."
    option :destination, aliases: :d, desc: "path where CSV file is saved to"
    def export(email)
      password = ask("Password for #{email}:", echo: false)
      puts ""

      crawler = BookmeterExporter::Crawler.new(email, password)
      books = crawler.crawl

      destination = options[:destination] || "./books.csv"
      IO.write(destination, books.to_csv)
      puts "Books are successfully exported as '#{destination}'."
    end

    desc "version", "Display version info"
    def version
      puts VERSION
    end
  end
end
