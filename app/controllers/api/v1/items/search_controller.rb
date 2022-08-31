class Api::V1::Items::SearchController < ApplicationController

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

end 
