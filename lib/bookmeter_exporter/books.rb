# frozen_string_literal: true

require "forwardable"

module BookmeterExporter
  Book = Struct.new(:asin, :read_date, :review)

  class Books
    extend Forwardable

    def_delegator :@books, :[]
    def_delegator :@books, :<<

    def initialize
      @books = []
    end

    def to_csv
      CSV.generate do |csv|
        @books.each do |book|
          csv << [book.asin, book.read_date, book.review]
        end
      end
    end
  end
end
