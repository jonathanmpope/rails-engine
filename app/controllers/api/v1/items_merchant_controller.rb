class Api::V1::ItemsMerchantController < ApplicationController
    
    def index 
        if Item.exists?(params[:item_id])
            item = Item.find(params[:item_id])
            render json: MerchantSerializer.new(item.merchant)
        else 
            render json: { error: "Item does not exist!" }, status: 404 
        end 
    end 
end 