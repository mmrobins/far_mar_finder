module FarMar
  class Product
    attr_reader :id, :name, :vendor_id, :sales

    def initialize(product_array)
      @id = product_array[0].to_i
      @name = product_array[1]
      @vendor_id = product_array[2].to_i
      @sales = []
    end

    def self.all(file_path="./support/products.csv")
      file_contents = CSV.read(file_path)
      @@products = file_contents.collect do |product|
        temp = Product.new(product)
        Vendor.find(temp.vendor_id).products << temp
        temp
      end
      Sale.all
      @@products
    end

    def vendor
      Vendor.find(@vendor_id)
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
