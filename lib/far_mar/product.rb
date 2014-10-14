module FarMar
  class Product

    attr_accessor :id, :name, :vendor_id

    def initialize(p_array)
      @id = p_array[0].to_i
      @name = p_array[1]
      @vendor_id = p_array[2].to_i
    end

    def self.all
      @products ||= CSV.read("support/products.csv").map do |p|
        Product.new(p)
      end
    end

    def self.find(id)
      all.find { |p| p.id == id }
    end

    def self.by_vendor(vendor_id)
      all.select { |p| p.vendor_id == vendor_id }
    end

    def self.find_by_name(name)
      all.find { |p| p.name.downcase == name.downcase }
    end

    def self.find_all_by_name(name)
      all.select { |p| p.name.downcase.include? name.downcase }
    end

    def self.most_revenue(n)
      all.sort_by { |p| p.revenue }.pop(n).reverse
    end

    def revenue
      r = sales.collect { |s| s.amount }
      r.inject(0) { |sum, i| sum + i }
    end

    def vendor
      FarMar::Vendor.all.find { |v| v.id == @vendor_id }
    end

    def sales
      FarMar::Sale.all_by_product[@id] || []
    end

    def number_of_sales
      sales.count
    end

  end
end
