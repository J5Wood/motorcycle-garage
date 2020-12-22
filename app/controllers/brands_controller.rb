class BrandsController < ApplicationController

    get '/brands' do
        redirect_if_not_logged_in
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
        redirect_if_not_logged_in
        erb :'brands/new'
    end

    get '/brands/:id' do
        redirect_if_not_logged_in
        @brand = Brand.find_by_id(params[:id])
        redirect_if_bad_route(@brand)
        erb :'brands/show'
    end

    get '/brands/:id/edit' do
        redirect_if_not_logged_in
        @brand = Brand.find_by_id(params[:id])
        redirect_if_bad_route(@brand)
        session[:brand_id] = @brand.id
        erb :'brands/edit'
    end

    patch '/brands/:id' do
        brand = Brand.find_by_id(params[:id])
        redirect_for_wrong_brand(brand)

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
        redirect_if_not_logged_in
        @brand = Brand.find_by_id(params[:id])
        redirect_if_bad_route(@brand)

        redirect_if_brand_has_motorcycles(@brand)
        erb :'brands/delete'
    end

    delete '/brands/:id' do
        brand = Brand.find_by_id(params[:id])
        redirect_if_brand_has_motorcycles(brand)
        brand.destroy
        redirect '/brands'
    end

    helpers do

        def redirect_if_brand_has_motorcycles(brand)
            if brand.motorcycles.count != 0
                flash[:message] = "Brand Still Has Motorcycles Garaged, Can't Delete"
                redirect '/brands'
            end
        end

        def redirect_for_wrong_brand(brand)
            if brand.id != session[:brand_id]
                flash[:message] = "Invalid Brand Change"
                redirect "/brands"
            end
        end
    end

end