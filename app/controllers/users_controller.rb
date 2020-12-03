class UsersController < ApplicationController

    get '/users/:id' do
        @user = User.find_by_id(session[:user_id])
        erb :'users/show'
    end

end