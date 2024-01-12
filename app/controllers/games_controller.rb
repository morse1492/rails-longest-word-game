require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @try = params[:try]
    @upcase = @try.upcase
    @letters = params[:letters].split
    @include = include(@upcase, @letters)
    @dictionary = dictionary(@upcase)
  end

  def include(guess,grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter)}
  end

  def dictionary(word)
    url = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    #URI.open => open the url address
    json = JSON.parse(url.read)
    json["found"]
  end
end
