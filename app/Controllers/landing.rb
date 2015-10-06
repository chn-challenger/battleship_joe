require './app/lib/board'
require './app/lib/ship'

module Battleships

  module Routes

    class Landing < Base

      get '/' do
        erb :'landing/homepage'
      end

      get '/test' do
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
