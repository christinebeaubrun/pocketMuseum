require 'open-uri'
require 'nokogiri'
# require 'pry'
# read from file

class MoMaScraper
  def initialize (url)
    @url = url
  end

  def print_to_screen
    puts "Check out the exhibition listings at the MOMA: "
    create_exhibitions_array.each do |hash|
      puts "Exhibition title: #{hash[:title]}"
      puts "Exhibition image: #{hash[:image]}"
      puts "Exhibition url: #{hash[:url]}"
      puts "---------------------------------------"
    end
  end
  
  def fetched_parsed_data
    response = open(@url)
    html = Nokogiri::HTML(response)
  end

  def list
    @list = fetched_parsed_data.css('div.JS_Features').children
  end

  def create_exhibitions_array
    @array = []
    @hash = {}
    list.each_with_index do |show, index|
      unless @array.length >= 3
        if index.odd?
          puts index
          @hash[:url] = show.attributes["href"].value # TO HASH OR NOT?
          # @hash[:image] = show.children[1].children[1].attributes["src"].value
          @hash[:title] = show.children[1].children[3].children[1].children.text
          @array << @hash
        end
      end
    end
    @array
  end
end

scraper = MoMaScraper.new('http://www.moma.org/visit/exhibitions')
# binding.pry