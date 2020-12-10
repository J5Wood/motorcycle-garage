class UsersController < ApplicationController

    get '/users/home' do
        if self.logged_in? 
            @user = User.find_by_id(session[:user_id])
            erb :'users/home'
        else
            redirect '/'
        end
    end

    get '/users/:id' do
        if self.logged_in?
            @user = User.find_by_id(params[:id])

            #Send to home page for self, otherwise user show page.
            if @user.id == session[:user_id]
                redirect '/users/home'
            else
                erb :'users/show'
            end
        else
            redirect '/'
        end
    end

    get '/users/:id/edit' do
        if self.logged_in?
            if session[:user_id] == params[:id].to_i
                @user = User.find_by_id(session[:user_id])
                erb :'users/edit'
            else
                flash[:message] = "You May Only Alter Your Own Profile"
                redirect '/'
            end
        else
            redirect "/"
        end
    end

    patch '/users/:id' do
        @user = User.find_by_id(params[:id])
        if params[:password_one] != params[:password_two]
            flash[:message] = "Passwords Must Match"
            redirect "/users/#{@user.id}/edit"
        end

        # Check for new name entry, then check if name is taken
        if !params[:username].empty? && params[:username] != @user.name
            if !User.find_by(name: params[:username])
                @user.name = params[:username]
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
        if self.logged_in?
            @user = User.find_by_id(session[:user_id])
            if @user.id == params[:id].to_i
                erb :'users/delete'
            else
                flash[:message] = "You May Only Delete Your Own Profile"
                redirect "/users/home"
            end
        else
            redirect "/"
        end
    end

    delete '/users/:id' do
        user = User.find_by_id(params[:id])
        Motorcycle.all.each do |bike|
            if bike.user_id.to_i == user.id
                bike.destroy
            end
        end
        user.destroy
        session.clear
        redirect "/"
    end
end