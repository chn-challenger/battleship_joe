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

      get '/users/dummy' do
        @username = session[:username]
        @user_ready = $users[session[:username]]
        @users = $users
        erb :'/users/dummy'
      end

      post '/users/ready' do
        $users[session[:username]] = true
        redirect '/users/ready'
      end

      get '/users/ready' do
        erb :'/users/ready', layout: false
      end


      get '/test' do
        erb :test
      end

    end

  end

end
