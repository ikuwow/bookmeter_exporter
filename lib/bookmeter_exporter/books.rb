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
  end
end
