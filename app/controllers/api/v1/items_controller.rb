class Api::V1::ItemsController < ApplicationController
    def index 
        render json: ItemSerializer.new(Item.all)
    end 

     def show 
        if Item.exists?(params[:id]) 
            render json: ItemSerializer.new(Item.find(params[:id]))
        else 
            render status: 404
        end 
    end 

    def create
        item = Item.new(item_params)
        if item.save
            render json: ItemSerializer.new(item), status: 201
        else 
            render status: 404
        end 
    end 

    def update 
        if Item.exists?(params[:id]) 
            item = Item.find(params[:id])
            if item.update(item_params)
                render json: ItemSerializer.new(item)
            else 
                render status: 404
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

    def find 
        if params[:name] != nil && params[:name] != "" && params[:min_price] == nil && params[:max_price] == nil
            item = Item.find_by_name(params[:name])
            render json: ItemSerializer.new(item)
        elsif params[:min_price] != nil && params[:max_price] == nil && params[:name] == nil
            item = Item.find_by_min_price(params[:min_price])
            render json: ItemSerializer.new(item)
        elsif params[:max_price] != nil && params[:min_price] == nil && params[:name] == nil
            item = Item.find_by_max_price(params[:max_price])
            render json: ItemSerializer.new(item)
        elsif params[:max_price] != nil && params[:min_price] != nil && params[:name] == nil
            item = Item.find_by_price_range(params[:min_price], params[:max_price])
            render json: ItemSerializer.new(item)
        else 
            render status: 404
        end 
    end 

    private 
    def item_params
        params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
    end 
end 