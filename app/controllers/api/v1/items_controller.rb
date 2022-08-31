class Api::V1::ItemsController < ApplicationController
    def index 
        json_response(ItemSerializer.new(Item.all), 200)
    end 

     def show 
        json_response(ItemSerializer.new(Item.find(params[:id])), 200)
    end 

    def create
        json_response(ItemSerializer.new(Item.create!(item_params)), 201)
    end 

    def update 
        if Item.exists?(params[:id]) 
            item = Item.find(params[:id])
            if item.update(item_params)
                render json: ItemSerializer.new(item)
            else 
                render json: { error: "Item was not updated" }, status: 404
            end 
        else 
            render status: 404
        end  
    end 

    def destroy 
        if Item.exists?(params[:id])
            item = Item.find(params[:id])
            item.destroy
        else 
            render status: 404
        end 
    end 

    private 
    def item_params
        params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
    end 
end 