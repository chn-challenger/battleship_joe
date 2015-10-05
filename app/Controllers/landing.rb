module Battleships

  module Routes

    class Landing < Base

      get '/' do
        erb :'landing/homepage'
      end

      get '/test' do
        erb :test
      end

    end

  end

end
