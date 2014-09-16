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
      @@sales = file_contents.collect do |sale|
        temp = Sale.new(sale)
        unless temp.vendor_id == 0 || temp.product_id == 0
          Vendor.find(temp.vendor_id).sales << temp
          Product.find(temp.product_id).sales << temp
        end
        temp
      end
    end

    def self.find(id)
      @@sales.find { |sale| sale.id == id }
    end
  end
end
