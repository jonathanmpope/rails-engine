class Api::V1::MerchantsController < ApplicationController
    def index 
        # render json: MerchantSerializer.new(Merchant.all)
        json_response(MerchantSerializer.new(Merchant.all), 200)
    end 

    def show 
        # if Merchant.exists?(params[:id])
            # render json: MerchantSerializer.new(Merchant.find(params[:id]))
            json_response(MerchantSerializer.new(Merchant.find(params[:id])), 200)
        # else 
            # render status: 404 
        # end 
    end 

    def create
        json_response(MerchantSerializer.new(Merchant.create(merchant_params)), 200)
    end
    
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

    private 
    def merchant_params
        params.require(:merchant).permit(:name)
    end 
end 