require 'sinatra/base'
require './app/controllers/base'
require './app/controllers/landing'

module Battleships

  class BattleshipsApp < Sinatra::Base

    use Routes::Landing

    # start the server if ruby file executed directly
    run! if app_file == $0
  end

end
