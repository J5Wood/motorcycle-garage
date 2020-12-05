class BrandsController < ApplicationController

    get '/brands/:id' do
        @brand = Brand.find_by_id(params[:id])
        erb :'brands/show'
    end
end