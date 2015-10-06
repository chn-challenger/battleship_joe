require 'sinatra/base'
require_relative 'controllers/base'
require './app/controllers/landing'
require './app/lib/game'
require './app/lib/player'
require './app/lib/board'
require './app/lib/ship'
require './app/controllers/fire'

module Battleships

  class BattleshipsApp < Sinatra::Base

    use Routes::Landing
    use Routes::Fire

    # start the server if ruby file executed directly
    run! if app_file == $0
  end

end
