class ApplicationController < Sinatra::Base

    set :public_dir, "../motorcycle-garage/app"
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }
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
        user = User.find_by(username: params[:username])

        if !!user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/users/#{user.id}"
        else
            flash[:message] = "Incorrect Username or Password"
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
        if !User.find_by(username: params[:username]) && !params[:username].empty? && !params[:password].empty?
            user = User.create(username: params[:username], password: params[:password])
            session[:user_id] = user.id
            redirect "/users/#{user.id}"
        elsif !!User.find_by(username: params[:username])
            flash[:message] = "Username Already Exists"
            redirect "/signup"
        else
            flash[:message] = "Must Include Username and Password"
            redirect "/signup"
        end
    end
    
    get '/logout' do
        session.clear
        redirect '/'
    end

    not_found do
        status 404
        erb :'failure'
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

        def redirect_if_bad_route(class_name)
            object_class = class_name.constantize
            valid_object = object_class.find_by_id(params[:id])

            # Check that object exists and route id is numeric
            if !valid_object || params[:id].to_i.to_s != params[:id]
               redirect "not_found"
            end
        end

    end
end