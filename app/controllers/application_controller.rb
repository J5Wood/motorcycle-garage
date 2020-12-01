class ApplicationController < Sinatra::Base
    set :views, 'app/views'
    set :session_secret, "Change_this_super_secret_password"
    enable :sessions

    get '/' do
        erb :'index'
    end

end