class Api::V1::Items::SearchController < ApplicationController

    def find 
        if params[:name] != nil && params[:name] != "" && params[:min_price] == nil && params[:max_price] == nil
            find_one_name_search(params[:name])
        elsif params[:min_price] != nil && params[:min_price].to_f >= 0 && params[:max_price] == nil && params[:name] == nil && params[:min_price] != ''
            find_one_price_search(params[:min_price])
        elsif params[:max_price] != nil && params[:max_price].to_f >= 0 && params[:min_price] == nil && params[:name] == nil && params[:max_price] != ''
            find_one_price_search(0, params[:max_price])
        elsif params[:max_price] != nil && params[:min_price] != nil && params[:name] == nil && params[:min_price].to_f < params[:max_price].to_f
            find_one_price_search(params[:min_price], params[:max_price])
        elsif params[:min_price].to_f < 0 || params[:max_price].to_f < 0
            render json: { error: "Number cannot be negative" }, status: 400 
        else 
            render status: 400
        end 
    end 

    def find_one_name_search(name)
        item = Item.find_by_name(name)
        item == nil ? (render json: { data: {} }) : (render json: ItemSerializer.new(item))
    end 

    def find_one_price_search(min = 0, max = Float::INFINITY)
        item = Item.find_one_by_price(min, max)
        item == nil ? (render json: { data: {} }) : (render json: ItemSerializer.new(item))
    end 

     def find_all  
        if params[:name] != nil && params[:name] != "" && params[:min_price] == nil && params[:max_price] == nil
             find_all_name_search(params[:name])
        elsif params[:min_price] != nil && params[:min_price].to_f >= 0 && params[:max_price] == nil && params[:name] == nil && params[:min_price] != ''
            find_all_price_search(params[:min_price])
        elsif params[:max_price] != nil && params[:max_price].to_f >= 0 && params[:min_price] == nil && params[:name] == nil && params[:max_price] != ''
            find_all_price_search(0, params[:max_price])
        elsif params[:max_price] != nil && params[:min_price] != nil && params[:name] == nil && params[:min_price].to_f < params[:max_price].to_f
            find_all_price_search(params[:min_price], params[:max_price])
        elsif params[:min_price].to_f < 0 || params[:max_price].to_f < 0
            render json: { error: "Number cannot be negative" }, status: 400 
        else 
            render status: 400
        end 
    end 

    def find_all_name_search(name)
        items = Item.find_all_by_name(name)
        items == nil ? (render json: { data: {} }) : (render json: ItemSerializer.new(items))
    end 

     def find_all_price_search(min = 0, max = Float::INFINITY)
        items = Item.find_all_by_price(min, max)
        items == nil ? (render json: { data: {} }) : (render json: ItemSerializer.new(items))
    end 
end 
