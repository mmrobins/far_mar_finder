module FarMar
  class Vendor
    # @@vendors = CSV.read("support/vendors.csv").map do |v|
    #   Vendor.new(v)
    # end

    attr_accessor :id, :name, :no_of_employees, :market_id

    def initialize(v_array)
      @id = v_array[0].to_i
      @name = v_array[1]
      @no_of_employees = v_array[2].to_i
      @market_id = v_array[3].to_i
    end

    def self.all
      @vendors ||= CSV.read("support/vendors.csv").map do |v|
        Vendor.new(v)
      end
    end

    def self.find(id)
      all.find { |v| v.id == id }
    end

    def self.by_market(market_id)
      all.select { |v| v.market_id == market_id }
    end

    def market
      FarMar::Market.all.find { |m| m.id == @market_id }
    end

    def sales
      FarMar::Sale.all.select { |s| s.vendor_id == @id }
    end

    def products
      FarMar::Product.all.select { |p| p.vendor_id == @id }
    end

    def revenue
      all_sales = sales.collect { |s| s.amount }
      all_sales.inject(0) { |sum, i| sum + i }
    end

  end

end
