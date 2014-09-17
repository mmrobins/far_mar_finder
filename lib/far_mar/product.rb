require "./lib/far_mar/aspect.rb"

module FarMar
  class Product < Aspect
    attr_reader :id, :name, :vendor_id

    def initialize(product_array)
      @id = product_array[0].to_i
      @name = product_array[1]
      @vendor_id = product_array[2].to_i
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
      sales.length
    end

    def self.by_vendor(vendor_id)
      all.find_all { |product| product.vendor_id == vendor_id }
    end

    def self.find(id)
      all.find { |product| product.id == id }
    end

    def self.most_revenue(n)
      rev_hash = revenue_hash
      revenue_array = rev_hash.values.sort.reverse
      revenue_array = revenue_array.slice(0...n)
      revenue_array.collect do |rev_amount|
        product_key = rev_hash.key(rev_amount)
        rev_hash.delete(product_key)
        product_key
      end
    end

    def self.revenue_hash
      rev_hash = {}
      all.each do |product|
        rev_hash[product] ||= product.revenue
      end
      rev_hash
    end

    def revenue
      sum = 0
      sales.each { |sale| sum += sale.amount }
      sum
    end
  end
end
