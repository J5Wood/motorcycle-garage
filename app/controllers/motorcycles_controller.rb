class MotorcyclesController < ApplicationController

    get '/motorcycles' do
        self.redirect_if_not_logged_in
        @motorcycles = Motorcycle.all.sort_by{|mc| mc.brand.name}
        erb :'motorcycles/index'
    end

    get '/motorcycles/new' do
        self.redirect_if_not_logged_in
        @brands = Brand.all
        erb :'motorcycles/new'
    end

    post '/motorcycles' do
        if valid_year?(params[:year]) && !params[:name].empty?
            motorcycle = Motorcycle.new(name: params[:name].upcase, year: params[:year].to_i)
            motorcycle.user = User.find_by_id(session[:user_id])
        else
            flash[:message] = "You Must Enter a Name and Valid Year"
            redirect '/motorcycles/new'
        end

        if params[:new_brand].empty? && !params[:brand]
            flash[:message] = "Please Select or Create a Brand"
            redirect '/motorcycles/new'

        elsif !params[:new_brand].empty?
            brand = Brand.find_by(name: params[:brand]) 
            if !brand
                motorcycle.brand = Brand.create(name: params[:new_brand].downcase.split.collect{|word| word.capitalize}.join(" "))
            else
                motorcycle.brand = brand
            end

        elsif !!params[:brand]
            motorcycle.brand = Brand.find_by(name: params[:brand])
        end

        if !params[:color].empty?
            motorcycle.color = params[:color]
        end

        if !params[:mileage].empty?
            motorcycle.mileage = params[:mileage]
        end

        motorcycle.save
        redirect "/motorcycles/#{motorcycle.id}" 
    end

    get '/motorcycles/:id' do
        self.redirect_if_not_logged_in
        self.redirect_if_bad_route(self.env["REQUEST_PATH"].split("/")[1][0...-1].capitalize)
        
        @motorcycle = Motorcycle.find_by_id(params[:id])
        erb :'motorcycles/show'
    end

    get '/motorcycles/:id/edit' do
        self.redirect_if_not_logged_in
        self.redirect_if_bad_route(self.env["REQUEST_PATH"].split("/")[1][0...-1].capitalize)
        
        @motorcycle = Motorcycle.find_by_id(params[:id])
        if session[:user_id] == @motorcycle.user.id
            @brands = Brand.all
            erb :'motorcycles/edit'
        else
            flash[:message] = "You May Only Alter Your Own Motorcycle"
            redirect "/motorcycles"
        end
    end 

    patch '/motorcycles/:id' do
        motorcycle = Motorcycle.find_by_id(params[:id])
        if valid_year?(params[:year])
            motorcycle.year = params[:year]     
        elsif !params[:year].empty?
            flash[:message] = "Please Enter a Valid Year"
            redirect "/motorcycles/#{motorcycle.id}/edit"
        end

        if !params[:name].empty?
            motorcycle.name = params[:name]
        end
        if !params[:color].empty?
            motorcycle.color = params[:color]
        end
        if !params[:mileage].empty?
            motorcycle.mileage = params[:mileage]
        end

        if !params[:new_brand].empty?
            brand = Brand.find_by(name: params[:brand])
            if !brand
                motorcycle.brand = Brand.create(name: params[:new_brand].downcase.capitalize)
            else
                motorcycle.brand = brand
            end
        elsif !!params[:brand]
            motorcycle.brand = Brand.find_by(name: params[:brand])
        end
        motorcycle.save
        redirect "/motorcycles/#{motorcycle.id}"
    end

    get '/motorcycles/:id/delete' do
        self.redirect_if_not_logged_in
        self.redirect_if_bad_route(self.env["REQUEST_PATH"].split("/")[1][0...-1].capitalize)
        
        @motorcycle = Motorcycle.find_by_id(params[:id])
        if @motorcycle.user_id.to_i == session[:user_id]
            erb :'motorcycles/delete'
        else
            flash[:message] = "You May Only Delete Your Own Motorcycle"
            redirect "/motorcycles/#{params[:id]}"
        end
    end

    delete '/motorcycles/:id' do
        Motorcycle.find_by_id(params[:id]).destroy
        redirect '/users/home'
    end

end