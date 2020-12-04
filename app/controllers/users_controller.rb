class UsersController < ApplicationController

    get '/users/:id' do
        @user = User.find_by_id(session[:user_id])
        erb :'users/show'
    end

    get '/users/:id/edit' do
        @user = User.find_by_id(session[:user_id])
        erb :'users/edit'
    end

    patch '/users/:id' do
        @user = User.find_by_id(params[:id])
        if params[:password_one] != params[:password_two]
            redirect "/users/#{@user.id}/edit"
        end
        if !params[:username].empty? && params[:username] != @user.name
            if !User.find_by(name: params[:username])
                @user.name = params[:username]
                @user.save
            else
                redirect "/users/#{@user.id}/edit"
            end
        end
        if !params[:password_one].empty?
            @user.password = params[:password_one]
            @user.save
        end
        redirect "/users/#{@user.id}"
    end

    
        
end