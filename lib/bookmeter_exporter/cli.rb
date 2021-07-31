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

    desc "export EMAIL", "Main export task"
    option :destination, aliases: :d
    def export(email)
      puts "Start"
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

    default_task :export
  end
end
