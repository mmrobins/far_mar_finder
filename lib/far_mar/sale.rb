module FarMar
  class Sale
    attr_reader :id, :amount, :purchase_time, :vendor_id, :product_id

    def initialize(sale_array)
      @id = sale_array[0].to_i
      @amount = sale_array[1].to_i
      @purchase_time = sale_array[2]
      @vendor_id = sale_array[3].to_i
      @product_id = sale_array[4].to_i
    end

    def self.all(file_path="./support/sales.csv")
      file_contents = CSV.read(file_path)
      @@sales = file_contents.collect { |sale| Sale.new(sale) }
    end

    def self.find(id)
      @@sales.find { |sale| sale.id == id }
    end

    def self.by_product(product_id)
      @@sales.find_all { |sale| sale.product_id == product_id }
    end

    def self.by_vendor(vendor_id)
      @@sales.find_all { |sale| sale.vendor_id == vendor_id }
    end

  end
end
