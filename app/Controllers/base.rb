require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/partial'

module Battleships

  module Routes

    class Base < Sinatra::Base
      use Rack::MethodOverride

      register Sinatra::Flash
      register Sinatra::Partial

      enable :sessions, :static
      enable :partial_underscores

      set :views, proc { File.join(root, '..', 'views')}

    end

  end

end
