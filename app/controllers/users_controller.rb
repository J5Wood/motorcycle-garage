class UsersController < ApplicationController

    get '/users/home' do
        self.redirect_if_not_logged_in
        @user = User.find_by_id(session[:user_id])
        erb :'users/home'
    end

    get '/users/:id' do
        self.redirect_if_not_logged_in
        @user = User.find_by_id(params[:id])

        #redirect for bad route
        if !@user
            redirect '/users/home'

        #Send to home page for self, otherwise user show page.
        elsif @user.id == session[:user_id]
            redirect '/users/home'
        else
            erb :'users/show'
        end
    end

    get '/users/:id/edit' do
        self.redirect_if_not_logged_in
        if session[:user_id] == params[:id].to_i
            @user = User.find_by_id(session[:user_id])
            erb :'users/edit'
        else
            flash[:message] = "You May Only Alter Your Own Profile"
            redirect '/'
        end
    end

    patch '/users/:id' do
        @user = User.find_by_id(params[:id])
        if params[:password_one] != params[:password_two]
            flash[:message] = "Passwords Must Match"
            redirect "/users/#{@user.id}/edit"
        end

        # Check for new name entry & change, then check if name is taken
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
        self.redirect_if_not_logged_in
        @user = User.find_by_id(session[:user_id])
        if @user.id == params[:id].to_i
            erb :'users/delete'
        else
            flash[:message] = "You May Only Delete Your Own Profile"
            redirect "/users/home"
        end
    end

    delete '/users/:id' do
        user = User.find_by_id(params[:id])
        user.destroy
        session.clear
        redirect "/"
    end
end