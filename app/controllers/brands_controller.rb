class BrandsController < ApplicationController

    get '/brands' do
        self.redirect_if_not_logged_in
        @brands = Brand.all.sort_by{|brand| brand.name }
        erb :'brands/index'
    end

    post '/brands' do
        if params[:name].empty?
            flash[:message] = "You Must Include a Brand Name"
            redirect '/brands/new'
        end

        brand = Brand.find_by(name: params[:name])
        if !brand
            brand = Brand.new(name: params[:name])
        else
            flash[:message] = "Brand Already Exists"
            redirect "/brands/#{brand.id}"
        end

        if valid_year?(params[:year])
            brand.year = params[:year]
        elsif !params[:year].empty?
            flash[:message] = "Must Enter a Valid Year"
            redirect "/brands/new"
        end

        if !params[:headquarters].empty?
            brand.headquarters = params[:headquarters]
        end
        brand.save
        redirect "/brands/#{brand.id}"
    end

    get '/brands/new' do
        self.redirect_if_not_logged_in
        erb :'brands/new'
    end

    get '/brands/:id' do
        self.redirect_if_not_logged_in
        self.redirect_if_bad_route(self.env["REQUEST_PATH"].split("/")[1][0...-1].capitalize)
        @brand = Brand.find_by_id(params[:id])
        erb :'brands/show'
    end

    get '/brands/:id/edit' do
        self.redirect_if_not_logged_in
        self.redirect_if_bad_route(self.env["REQUEST_PATH"].split("/")[1][0...-1].capitalize)
        @brand = Brand.find_by_id(params[:id])
        erb :'brands/edit'
    end

    patch '/brands/:id' do
        brand = Brand.find_by_id(params[:id])
        if !params[:name].empty?
            brand.name = params[:name]
        end

        if valid_year?(params[:year])
            brand.year = params[:year]
        elsif !params[:year].empty?
            flash[:message] = "You Must Enter a Valid Year"
            redirect "/brands/#{brand.id}/edit"
        end

        if !params[:headquarters].empty?
            brand.headquarters = params[:headquarters]
        end
        brand.save
        redirect "/brands/#{brand.id}"
    end

    get '/brands/:id/delete' do
        self.redirect_if_not_logged_in
        self.redirect_if_bad_route(self.env["REQUEST_PATH"].split("/")[1][0...-1].capitalize)
        @brand = Brand.find_by_id(params[:id])
        if @brand.motorcycles.count == 0
            erb :'brands/delete'
        else
            flash[:message] = "Brand Still Has Motorcycles Garaged, Can't Delete"
            redirect "/brands/#{@brand.id}"
        end
    end

    delete '/brands/:id' do
        Brand.find_by_id(params[:id]).destroy
        redirect '/brands'
    end

end