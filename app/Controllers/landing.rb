require './app/lib/board'
require './app/lib/ship'

module Battleships

  module Routes

    class Landing < Base

      get '/' do
        erb :'landing/homepage'
      end

      get '/test' do
        # board = Board.new
        # ship1 = Ship.new
        # ship2 = Ship.new(3)
        # ship3 = Ship.new(4)
        # ship4 = Ship.new(3)
        # ship5 = Ship.new(5)
        # board.place_ship_at_random(ship1)
        # board.place_ship_at_random(ship2)
        # board.place_ship_at_random(ship3)
        # board.place_ship_at_random(ship4)
        # board.place_ship_at_random(ship5)
        # 20.times {board.fire_missile_at_random}
        # @result = board.print_board
        erb :test
      end

      get '/test/:id' do
        @hitArray = []
        @hitArray << params[:id]
        p @hitArray
        redirect to('/test')
      end

    end

  end

end
