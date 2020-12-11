class ApplicationController < Sinatra::Base

    set :views, 'app/views'
    set :session_secret, "Change_this_super_secret_password"
    enable :sessions
    register Sinatra::Flash
   

    get '/' do
        if  !self.logged_in?
            erb :'index', :layout => false
        else
            redirect "/users/home"
        end
    end

    get '/login' do
        if  !self.logged_in?
            erb :'login', :layout => false
        else
            redirect "/users/home"
        end
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
        if !self.logged_in?
            erb :'signup', :layout => false
        else
            redirect "users/home"
        end
    end

    post '/signup' do
        if !User.find_by(name: params[:username]) && !params[:username].empty? && !params[:password].empty?
            user = User.create(name: params[:username], password: params[:password])
            session[:user_id] = user.id
            redirect "/users/#{user.id}"
        else
            redirect "/signup"
        end
    end
    
    get '/logout' do
        session.clear
        redirect '/'
    end


    helpers do

        def logged_in?
          !!session[:user_id]
        end

        def redirect_if_not_logged_in
            if !session[:user_id]
                redirect '/'
            end
        end

        def valid_year?(year)
            year.to_i.between?(1885, DateTime.now.year + 1)      
        end

    end
end