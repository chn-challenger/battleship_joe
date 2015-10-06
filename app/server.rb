require 'sinatra/base'
require './app/controllers/base'
require './app/controllers/landing'
require './app/lib/game'
require './app/lib/player'
require './app/lib/board'
require './app/lib/ship'


module Battleships

  class BattleshipsApp < Sinatra::Base

    use Routes::Landing

    # start the server if ruby file executed directly
    run! if app_file == $0
  end

end
