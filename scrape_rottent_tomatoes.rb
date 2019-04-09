require 'rest-client'
require 'nokogiri'
require 'json'

class Movie
  def  score= score
      @score = score
  end
  def  name= name
      @name = name
  end
  def  sales= sales
      @sales = sales
  end
end

document = RestClient.get('http://www.rottentomatoes.com')
dom = Nokogiri::HTML(document)
movies = []

dom.css('#Top-Box-Office tr').each do |movie_tr|
  movie = Movie.new
  movie.name = movie_tr.css('.middle_col a').text
  movie.sales = movie_tr.css('.right_col').text
  movie.score = movie_tr.css('.left_col .tMeterScore').text
  movies << movie
end

# Movies
movies.each do |mov|
  puts JSON.dump mov
end