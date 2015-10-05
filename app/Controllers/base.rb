require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/partial'

module Battleships

  module Routes

    class Base < Sinatra::Base
      use Rack::MethodOverride

      register Sinatra::Flash
      register Sinatra::Partial

      enable :sessions
      enable :static
      enable :partial_underscores

      set :public_folder, proc {File.join(root, '..', 'public')}
      set :views, proc { File.join(root, '..', 'views')}
      set :partial_template_engine, :erb

    end

  end

end
