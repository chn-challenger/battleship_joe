require './app/lib/board'
require './app/lib/ship'

module Battleships

  module Routes

    class Landing < Base

      get '/' do
        erb :'landing/homepage'
      end

      get '/users/new' do
        @username = session[:username]
        erb :'/users/new'
      end

      # post '/test', :provides => :json do
      #   begin
      #     params = JSON.parse(request.env["rack.input"].read)
      #     co_ordinates = []
      #     params.each {|x| co_ordinates << x.to_i }
      #   end
      # end

      post '/users/sign-up' do
        session[:username] = params[:username]
        $users ||= {}
        $users[session[:username]]=false
        redirect '/users/ready'
      end

      get '/users/ready' do
        @username = session[:username]
        @user_ready = $users[session[:username]]
        @users = $users
        erb :'/users/ready'
      end

      post '/users/ready' do
        $users[session[:username]] = true
        redirect '/users/ready'
      end

      get '/game/new' do
        if $new_game
          $new_game.player2.name = session[:username]
        else
          $new_game = Game.new
          player1 = Player.new
          player2 = Player.new
          player1.name = session[:username]
          fleet1 = [Ship.new(2), Ship.new(3), Ship.new(4), Ship.new(4), Ship.new(5)]
          fleet2 = [Ship.new(2), Ship.new(3), Ship.new(4), Ship.new(4), Ship.new(5)]
          board1 = Board.new
          board2 = Board.new
          $new_game.add_player(player1)
          $new_game.add_player(player2)
          player1.board = board1
          player2.board = board2
          fleet1.each do |ship|
            board1.place_ship_at_random(ship)
          end
          fleet2.each do |ship|
            board2.place_ship_at_random(ship)
          end
        end
        @player1_name = $new_game.player1.name
        @player2_name = $new_game.player2.name
        @username = session[:username]
        @turn = $new_game.turn.name
        @board_display1 = $new_game.player1.board.print_board
        @opponent_display1 = $new_game.player2.board.print_opponent_board
        @board_display2 = $new_game.player2.board.print_board
        @opponent_display2 = $new_game.player1.board.print_opponent_board
        erb :'/game/new'
      end

      # get '/users/ready' do
      #   erb :'/users/ready', layout: false
      # end

    post '/game/new/player1' do
      coords = params[:coords].split(",")
      new_coords = []

      coords.each do |n|
        new_coords << n.to_i
      end
      p new_coords
      $new_game.shoots(new_coords)
      redirect '/game/new/player1'
    end

    get '/game/new/player1' do
      @username = session[:username]
      @turn = $new_game.turn.name
      @board_display1 = $new_game.player1.board.print_board
      @opponent_display1 = $new_game.player2.board.print_opponent_board
      erb :'game/player1'
    end

    post '/game/new/player2' do
      coords = params[:coords].split(",")
      new_coords = []

      coords.each do |n|
        new_coords << n.to_i
      end
      p new_coords
      $new_game.shoots(new_coords)
      redirect '/game/new/player2'
    end

    get '/game/new/player2' do
      @username = session[:username]
      @turn = $new_game.turn.name
      @board_display2 = $new_game.player2.board.print_board
      @opponent_display2 = $new_game.player1.board.print_opponent_board
      erb :'game/player2'
    end

    end

  end

end
