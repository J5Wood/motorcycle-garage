class MotorcyclesController < ApplicationController

    get '/motorcycles' do
        @motorcycles = Motorcycle.all
        erb :'motorcycles/index'
    end

    get '/motorcycles/:id' do
        @motorcycle = Motorcycle.find_by_id(params[:id])
        erb :'motorcycles/show'
    end

end