require './app/lib/board'
require './app/lib/ship'
require './app/lib/game'
require './app/lib/player'

module Battleships

  module Routes

    class Fire < Base

      $game = Game.new

      $board1 = Board.new
      $board2 = Board.new

      $player1 = Player.new
      $player2 = Player.new

      $fleet1 = [Ship.new(2), Ship.new(3), Ship.new(4), Ship.new(4), Ship.new(5)]
      $fleet2 = [Ship.new(2), Ship.new(3), Ship.new(4), Ship.new(4), Ship.new(5)]

      $game.add_player($player1)
      $game.add_player($player2)

      $player1.board = $board1
      $player2.board = $board2

      $fleet1.each do |ship|
        $board1.place_ship_at_random(ship)
      end

      $fleet2.each do |ship|
        $board2.place_ship_at_random(ship)
      end

      get '/fire' do
        @coords = params[:coords].split(',').map { |x| x.to_i } if params[:coords] != nil
        $player2.board.fire_missile(@coords) if params[:coords] != nil
        @board_display = $player1.board.print_board
        @opponent_display = $player2.board.print_opponent_board
        erb :'fire/fire'
      end

    end

  end

end
