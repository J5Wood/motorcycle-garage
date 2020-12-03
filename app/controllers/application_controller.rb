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
        binding.pry
        user = User.find_by(name: params[:username])

        if !!user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/users/#{user.id}"
        else
            redirect '/login'
        end
    end

    get 'signup' do
        erb :'signup'
    end

end