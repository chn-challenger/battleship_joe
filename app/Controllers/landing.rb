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
        erb :'/game/new'
      end

      # get '/users/ready' do
      #   erb :'/users/ready', layout: false
      # end


      get '/game/new' do
        erb :test
      end

    end

  end

end
