module FarMar
  class Vendor
    attr_reader :id, :name, :employees, :market_id, :products, :sales

    def initialize(vendor_array)
      @id = vendor_array[0].to_i
      @name = vendor_array[1]
      @employees = vendor_array[2]
      @market_id = vendor_array[3].to_i
      @sales = []
      @products = []
    end

    def self.all(file_path="./support/vendors.csv")
      file_contents = CSV.read(file_path)
      @@vendors = file_contents.collect do |vendor|
        temp = Vendor.new(vendor)
        Market.find(temp.market_id).vendors << temp
        temp
      end
      Product.all
      @@vendors
    end

    def market
      Market.find(@market_id)
    end

    def revenue
      sum = 0
      @sales.each do |sale|
        sum += sale.amount
      end
      sum
    end

    def self.by_market(market_id)
      @@vendors.find_all { |vendor| vendor.market_id == market_id }
    end

    def self.find(id)
      @@vendors.find { |vendor| vendor.id == id }
    end
  end
end
