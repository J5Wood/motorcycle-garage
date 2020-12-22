class UsersController < ApplicationController

    get '/users/home' do
        redirect_if_not_logged_in
        @user = User.find_by_id(session[:user_id])
        erb :'users/home'
    end

    get '/users/:id' do
        redirect_if_not_logged_in
        @user = User.find_by_id(params[:id])
        redirect_if_bad_route(@user)

        if @user.id == session[:user_id]
            redirect '/users/home'
        else
            erb :'users/show'
        end
    end

    get '/users/:id/edit' do
        redirect_if_not_logged_in
        @user = User.find_by_id(params[:id])
        redirect_if_bad_route(@user)
        redirect_if_incorrect_user(@user)

        erb :'users/edit'
    end

    patch '/users/:id' do
        @user = User.find_by_id(params[:id])
        redirect_if_incorrect_user(@user)

        if params[:password_one] != params[:password_two]
            flash[:message] = "Passwords Must Match"
            redirect "/users/#{@user.id}/edit"
        end

        # Check for new name entry & name change, then check if name is taken
        if !params[:username].empty? && params[:username] != @user.username
            if !User.find_by(username: params[:username])
                @user.username = params[:username]
                @user.save
            else
                flash[:message] = "Name Already Taken, Please Try Another"
                redirect "/users/#{@user.id}/edit"
            end
        end
        if !params[:password_one].empty?
            @user.password = params[:password_one]
            @user.save
        end
        redirect "/users/home"
    end  

    get '/users/:id/delete' do
        redirect_if_not_logged_in
        @user = User.find_by_id(params[:id])
        redirect_if_bad_route(@user)
        redirect_if_incorrect_user(@user)

        erb :'users/delete'
    end

    delete '/users/:id' do
        user = User.find_by_id(params[:id])
        redirect_if_incorrect_user(user)
        user.destroy
        session.clear
        redirect "/"
    end


    helpers do

        def redirect_if_incorrect_user(user)
            if session[:user_id] != user.id
                flash[:message] = "You May Only Alter Your Own Profile"
                redirect "/users/home"
            end
        end
    end
end