require 'sinatra/base'
require './app/controllers/base'
require './app/controllers/landing'
require './app/controllers/fire'

module Battleships

  class BattleshipsApp < Sinatra::Base

    use Routes::Landing
    use Routes::Fire

    # start the server if ruby file executed directly
    run! if app_file == $0
  end

end
