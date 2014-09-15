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
      @@products = file_contents.collect do |product|
        temp = Product.new(product)
        Vendor.find(temp.vendor_id).products << temp
      end
    end

    def self.find(id)
      @@products.find { |product| product.id == id }
    end
  end
end
