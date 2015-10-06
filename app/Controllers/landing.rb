module Battleships

  module Routes

    class Landing < Base

      get '/' do
        erb :'landing/homepage'
      end

      get '/test' do
        erb :test
      end

      get '/test/:id' do
        # @hitArray = []
        # @hitArray << params[:id]
        # p @hitArray
        # redirect to('/test')
      end

    end

  end

end
