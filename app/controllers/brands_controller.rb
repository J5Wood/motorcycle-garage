class BrandsController < ApplicationController

    get '/brands' do
        if self.logged_in?
            @brands = Brand.all.sort_by{|brand| brand.name }
            erb :'brands/index'
        else
            redirect '/'
        end
    end

    post '/brands' do
        if params[:name].empty?
            flash[:message] = "You Must Include a Brand Name"
            redirect '/brands/new'
        end
        brand = Brand.find_by(name: params[:name])
        if !brand
            brand = Brand.create(name: params[:name])
        else
            flash[:message] = "Brand Already Exists"
            redirect "/brands/#{brand.id}"
        end
        if !params[:year].empty?
            brand.year = params[:year]
        end
        if !params[:headquarters].empty?
            brand.headquarters = params[:headquarters]
        end
        brand.save
        redirect "/brands/#{brand.id}"
    end

    get '/brands/new' do
        if self.logged_in?
            erb :'brands/new'
        else
            redirect '/'
        end
    end

    get '/brands/:id' do
        if self.logged_in?
            @brand = Brand.find_by_id(params[:id])
            erb :'brands/show'
        else
            redirect '/'
        end
    end

    get '/brands/:id/edit' do
        if self.logged_in?
            @brand = Brand.find_by_id(params[:id])
            erb :'brands/edit'
        else
            redirect '/'
        end
    end

    patch '/brands/:id' do
        brand = Brand.find_by_id(params[:id])
        if !params[:name].empty?
            brand.name = params[:name]
        end
        if !params[:year].empty?
            brand.year = params[:year]
        end
        if !params[:headquarters].empty?
            brand.headquarters = params[:headquarters]
        end
        brand.save
        redirect "/brands/#{brand.id}"
    end

    get '/brands/:id/delete' do
        if self.logged_in?
            @brand = Brand.find_by_id(params[:id])
            if @brand.motorcycles.count == 0
                erb :'brands/delete'
            else
                flash[:message] = "Brand Still Has Motorcycles, Can't Delete"
                redirect "/brands/#{@brand.id}"
            end
        else
            redirect '/'
        end
    end

    delete '/brands/:id' do
        Brand.find_by_id(params[:id]).destroy
        redirect '/brands'
    end

end