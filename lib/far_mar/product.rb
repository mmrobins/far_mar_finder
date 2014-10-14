module FarMar
  class Product < Aspect
    set_path "./support/products.csv"
    attr_reader :id, :name, :vendor_id

    def initialize(product_array)
      @id = product_array[0].to_i
      @name = product_array[1]
      @vendor_id = product_array[2].to_i
    end

    def vendor
      Vendor.find(@vendor_id)
    end

    def sales
      Sale.by_product(@id)
    end

    def number_of_sales
      sales.length
    end

    def self.by_vendor(vendor_id)
      all.find_all { |product| product.vendor_id == vendor_id }
    end

    def self.most_revenue(n)
      all.sort_by(&:revenue).reverse[0..n-1]
    end

    def revenue
      sum = 0
      sales.each { |sale| sum += sale.amount }
      sum
    end
  end
end
