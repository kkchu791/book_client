require 'httparty'
require 'byebug'

class BookSelector

  attr_reader :keyword
  def initialize(keyword)
    @keyword = keyword
    @list = []
    @reading_list = []
  end

  def hello_world
    puts "Welcome!"
  end

  def start
    hello_world

    puts "what book are you looking for?"
    @keyword = gets.chomp

    search.each_with_index do |book_record, index|
      puts "#{index + 1}. #{book_record}}"
    end
    puts "Here are your books:"
    puts "Choose the book you want to add to your reading list: (or type exit to leave)"
    book_num = gets.chomp
    res = []

    @list.each_with_index do |book, index|
      if (index + 1) == book_num.to_i
        res << book
      end
    end

    puts "Your reading list: "

    res.each do |book|
      puts book
    end
  end

  def search
    response = HTTParty.get("https://www.googleapis.com/books/v1/volumes?q=#{keyword}")
    json = JSON.parse(response.body)
    json["items"].first(5).map do |book|
      book_data = book["volumeInfo"]

      hash = {}
      hash["author"] = book_data["authors"].join("")
      hash["title"] = book_data["title"]
      hash["publisher"] = book_data["publisher"]
      @list << hash
    end


    @list
  end
end

selector = BookSelector.new("war")
selector.start
