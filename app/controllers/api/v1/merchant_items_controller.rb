class Api::V1::MerchantItemsController < ApplicationController
    def index 
        if Merchant.exists?(params[:merchant_id])
            merchant = Merchant.find(params[:merchant_id])
            merchant.items.count == nil ? (render json: { data: {} }) : (render json: ItemSerializer.new(merchant.items))
        else 
            render json: { error: "Merchant does not exist!" }, status: 404 
        end 
    end 
end 
