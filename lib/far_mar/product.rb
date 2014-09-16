module FarMar
  class Product
    attr_accessor :id, :name, :vendor_id

    def initialize(p_array)
      @id = p_array[0].to_i
      @name = p_array[1]
      @vendor_id = p_array[2].to_i
    end

    def self.all
      @products = CSV.read("support/products.csv").map do |p|
        Product.new(p)
      end
    end

    def self.find(id)
      @products.find { |p| p.id == id }
    end

    def self.by_vendor(vendor_id)
      @products.select { |p| p.vendor_id == vendor_id }

    end

    def vendor
      FarMar::Vendor.all.find { |v| v.id == @vendor_id }
    end

    def sales
      FarMar::Sale.all.select { |s| s.product_id == @id }
    end

  end
end
