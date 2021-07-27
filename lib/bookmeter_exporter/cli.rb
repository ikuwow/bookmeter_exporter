# frozen_string_literal: true

require "thor"
require_relative "crawler"

module BookmeterExporter
  class CLI < Thor
    desc "export", "Main export task"
    def export(email = 'email', password = 'password')
      puts "Start"
      crawler = BookmeterExporter::Crawler.new(email, password)
      crawler.crawl
      puts "End"
    end

    default_task :export
  end
end
