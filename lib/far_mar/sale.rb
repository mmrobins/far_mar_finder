module FarMar
  class Sale
    attr_accessor :id, :amount, :purchase_time, :vendor_id, :product_id

    def initialize(s_array)
      @id = s_array[0].to_i
      @amount = s_array[1]
      @purchase_time = s_array[2]
      @vendor_id = s_array[3].to_i
      @product_id = s_array[4].to_i
    end

    def self.all
      @sales = CSV.read("support/sales.csv").map do |s|
        Sale.new(s)
      end
    end
  end

end
