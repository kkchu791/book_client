require 'httparty'
require 'byebug'

class BookSelector

  attr_reader :keyword
  def initialize(keyword)
    @keyword = keyword
  end

  def hello_world
    puts "hello world"
  end

  def search
    response = HTTParty.get("https://www.googleapis.com/books/v1/volumes?q=#{keyword}")
    json = JSON.parse(response.body)
    res = json["items"].first(5).map do |book|
      book_data = book["volumeInfo"]

      hash = {}
      hash["author"] = book_data["authors"].join("")
      hash["title"] = book_data["title"]
      hash["publisher"] = book_data["publisher"]
      hash
    end


    puts res
  end
end

selector = BookSelector.new("war")
selector.search
