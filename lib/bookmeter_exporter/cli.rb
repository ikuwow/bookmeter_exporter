# frozen_string_literal: true

require "thor"
require_relative "crawler"

module BookmeterExporter
  class CLI < Thor
    class << self
      def exit_on_failure?
        true
      end
    end

    desc "export EMAIL", "Main export task"
    def export(email)
      puts "Start"
      password = ask("Password for #{email}:")
      crawler = BookmeterExporter::Crawler.new(email, password)
      crawler.crawl
      puts "End"
    end

    default_task :export
  end
end
