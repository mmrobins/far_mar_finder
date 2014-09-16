module FarMar
  class Vendor
    attr_accessor :id, :name, :no_of_employees, :market_id

    def initialize(v_array)
      @id = v_array[0].to_i
      @name = v_array[1]
      @no_of_employees = v_array[2]
      @market_id = v_array[3].to_i
    end

    def self.all
      @vendors = CSV.read("support/vendors.csv").map do |v|
        Vendor.new(v)
      end
    end

    def self.find(id)
      @vendors.find { |v| v == id }
    end

    def self.by_market(market_id)
      @vendors.select { |v| v.market_id == market_id }
    end
  end

end
