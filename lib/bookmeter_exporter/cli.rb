# frozen_string_literals: true

require "thor"

module BookmeterExporter
  class CLI < Thor
    desc "export", "Main export task"
    def export
      puts "Howdy"
    end

    default_task :export
  end
end
