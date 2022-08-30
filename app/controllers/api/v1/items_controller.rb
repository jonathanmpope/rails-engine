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
            render json: { error: "Item was not created" }, status: 404
        end 
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

    def find 
        if params[:name] != nil && params[:name] != "" && params[:min_price] == nil && params[:max_price] == nil
            render json: Item.find_by_name(params[:name])
        elsif params[:min_price] != nil && params[:min_price].to_f >= 0 && params[:max_price] == nil && params[:name] == nil && params[:min_price] != ''
            render json: Item.find_by_min_price(params[:min_price])
        elsif params[:max_price] != nil && params[:max_price].to_f >= 0 && params[:min_price] == nil && params[:name] == nil && params[:max_price] != ''
            render json: Item.find_by_max_price(params[:max_price])
        elsif params[:max_price] != nil && params[:min_price] != nil && params[:name] == nil && params[:min_price].to_f < params[:max_price].to_f
            render json: Item.find_by_price_range(params[:min_price], params[:max_price])
        elsif params[:min_price].to_f < 0 || params[:max_price].to_f < 0
            render json: { error: "Number cannot be negative" }, status: 400 
        else 
            render status: 400
        end 
    end 

     def find_all  
        if params[:name] != nil && params[:name] != "" && params[:min_price] == nil && params[:max_price] == nil
            render json: Item.find_all_by_name(params[:name])
        elsif params[:min_price] != nil && params[:min_price].to_f >= 0 && params[:max_price] == nil && params[:name] == nil && params[:min_price] != ''
            render json: Item.find_all_by_min_price(params[:min_price])
        elsif params[:max_price] != nil && params[:max_price].to_f >= 0 && params[:min_price] == nil && params[:name] == nil && params[:max_price] != ''
            render json: Item.find_all_by_max_price(params[:max_price])
        elsif params[:max_price] != nil && params[:min_price] != nil && params[:name] == nil && params[:min_price].to_f < params[:max_price].to_f
            render json: Item.find_all_by_price_range(params[:min_price], params[:max_price])
        elsif params[:min_price].to_f < 0 || params[:max_price].to_f < 0
            render json: { error: "Number cannot be negative" }, status: 400 
        else 
            render status: 400
        end 
    end 

    private 
    def item_params
        params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
    end 
end 