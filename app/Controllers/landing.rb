require './app/lib/board'
require './app/lib/ship'

module Battleships

  module Routes

    class Landing < Base

      get '/' do
        erb :'landing/homepage'
      end

      get '/test' do
        board1 = Board.new
        board2 = Board.new
        @result = board1.print_board
        @opponent_result = board2.print_opponet_board


        erb :test
      end

      post '/test', :provides => :json do
        begin
          params = JSON.parse(request.env["rack.input"].read)
          co_ordinates = []
          params.each {|x| co_ordinates << x.to_i }
        end
      end
    end

  end

end
