class Item < ApplicationRecord
    before_destroy :destroy_all_invoices_with_only_one_item

    belongs_to :merchant 
    has_many :invoice_items, dependent: :destroy
    has_many :invoices, through: :invoice_items

    validates_presence_of :name 
    validates_presence_of :description 
    validates_presence_of :unit_price
    validates_presence_of :merchant_id

    def destroy_all_invoices_with_only_one_item
        invoices.each { |invoice| invoice.items.count == 1 ? invoice.destroy : nil }
    end 

    def self.find_by_name(name)
        where("name ILIKE ?", "%#{name}%").order(:name).first 
    end 

    def self.find_one_by_price(min, max)
        where("unit_price >= ? AND unit_price <= ?", min.to_f, max.to_f).order(:name).first 
    end

    def self.find_all_by_name(name)
        where("name ILIKE ?", "%#{name}%") 
    end

    def self.find_all_by_price(min, max)
        where("unit_price >= ? AND unit_price <= ?", min.to_f, max.to_f)
    end
end 