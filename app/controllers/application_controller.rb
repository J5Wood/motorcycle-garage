class ApplicationController < Sinatra::Base
    set :views, 'app/views'
    set :session_secret, "Change_this_super_secret_password"
    enable :sessions

    get '/' do
        erb :'index'
    end

    get '/login' do
        erb :'login'
    end

    post '/login' do
        user = User.find_by(name: params[:username])

        if !!user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/users/#{user.id}"
        else
            redirect '/login'
        end
    end

    get '/signup' do
        erb :'signup'
    end

    post '/signup' do
        if !User.find_by(name: params[:username])
            user = User.create(name: params[:username], password: params[:password])
            session[:user_id] = user.id
            redirect "/users/#{user.id}"
        else
            redirect "/signup"
        end
    end


    helpers do
        def logged_in?
          !!session[:user_id]
        end
    end
end