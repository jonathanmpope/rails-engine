class Api::V1::MerchantsController < ApplicationController
    def index 
        json_response(MerchantSerializer.new(Merchant.all), 200)
    end 

    def show 
        json_response(MerchantSerializer.new(Merchant.find(params[:id])), 200)
    end 

    def create
        json_response(MerchantSerializer.new(Merchant.create(merchant_params)), 200)
    end

    private 
    def merchant_params
        params.require(:merchant).permit(:name)
    end 
end 