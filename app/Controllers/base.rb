require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/partial'
require 'json'
require 'pusher'

Pusher.app_id = '146746'
Pusher.key = 'de93a8d7bd72a9d93113'
Pusher.secret = '5047b2b1b8bf246b50ad'

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
