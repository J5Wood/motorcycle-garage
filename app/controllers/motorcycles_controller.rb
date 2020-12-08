class MotorcyclesController < ApplicationController

    get '/motorcycles' do
        if self.logged_in?
            @motorcycles = Motorcycle.all
            erb :'motorcycles/index'
        else
            redirect '/'
        end
    end

    get '/motorcycles/new' do
        if self.logged_in?
            @brands = Brand.all
            erb :'motorcycles/new'
        else
            redirect '/'
        end
    end

    post '/motorcycles' do
        if params[:year].to_i.between?(1885, DateTime.now.year + 1) && !params[:name].empty?  #Verify proper year and year format
            motorcycle = Motorcycle.new(name: params[:name].upcase, year: params[:year].to_i)
            motorcycle.user = User.find_by_id(session[:user_id])
        else
            redirect '/motorcycles/new'
        end

        if params[:new_brand].empty? && !params[:brand]
            redirect '/motorcycles/new'
        elsif !params[:new_brand].empty?
            brand = Brand.find_by(name: params[:brand])      #Make work with multiple words
            if !brand
                motorcycle.brand = Brand.create(name: params[:new_brand].downcase.capitalize)
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
        if self.logged_in?
            @motorcycle = Motorcycle.find_by_id(params[:id])
            erb :'motorcycles/show'
        else
            redirect '/'
        end
    end

    get '/motorcycles/:id/edit' do
        if self.logged_in?
            @motorcycle = Motorcycle.find_by_id(params[:id])
            if session[:user_id] == @motorcycle.user.id
                @brands = Brand.all
                erb :'motorcycles/edit'
            else
                redirect "/motorcycles/#{@motorcycle.id}"
            end
        else
            redirect '/'
        end
    end 

    patch '/motorcycles/:id' do
        motorcycle = Motorcycle.find_by_id(params[:id])
        if !params[:year].empty?
            motorcycle.year = params[:year]
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
            brand = Brand.find_by(name: params[:brand])      #Make work with multiple words
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

end