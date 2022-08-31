class Api::V1::Merchants::SearchController < ApplicationController

    def find_all
        if params[:name] != nil && params[:name] != ''
            render json: Merchant.find_by_name(params[:name])
        else 
            render status: 400
        end 
    end 

    def find
        if params[:name] != nil && params[:name] != ''
            render json: Merchant.find_one_by_name(params[:name])
        else 
            render status: 400
        end 
    end

end 