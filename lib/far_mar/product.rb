module FarMar
  class Product
    attr_reader :id, :name, :vendor_id

    def initialize(product_array)
      @id = product_array[0].to_i
      @name = product_array[1]
      @vendor_id = product_array[2].to_i
    end

    def self.all(file_path="./support/products.csv")
      file_contents = CSV.read(file_path)
      @@products = file_contents.collect {|product| Product.new(product)}
    end

    def vendor
      Vendor.all
      Vendor.find(@vendor_id)
    end

    def sales
      Sale.all
      Sale.by_product(@id)
    end

    def number_of_sales
      @sales.length
    end

    def self.by_vendor(vendor_id)
      @@products.find_all { |product| product.vendor_id == vendor_id }
    end

    def self.find(id)
      @@products.find { |product| product.id == id }
    end
  end
end
