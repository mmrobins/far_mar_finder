module FarMar
  class Vendor < Aspect
    set_path "./support/vendors.csv"
    attr_reader :id, :name, :no_of_employees, :market_id

    def initialize(vendor_array)
      @id = vendor_array[0].to_i
      @name = vendor_array[1]
      @no_of_employees = vendor_array[2].to_i
      @market_id = vendor_array[3].to_i
    end

    def market
      Market.find(@market_id)
    end

    def products
      Product.by_vendor(@id)
    end

    def revenue(date = nil)
      return 0 unless sales
      sum = 0
      sales(date).each { |sale| sum += sale.amount }
      sum
    end

    def sales(date = nil) #date is a date object (not a date time obj)
      sales = Sale.by_vendor(@id)
      if date != nil
        sales = sales.find_all { |sale| sale.purchase_time === date }
      end
      sales
    end

    def self.most_items(n)
      sales_hash = sales_count_hash
      sales_array = sales_hash.values.sort.reverse
      sales_array = sales_array.slice(0...n)
      sales_array.collect do |sales_count|
        vendor_key = sales_hash.key(sales_count)
        sales_hash.delete(vendor_key)
        vendor_key
      end
    end

    def self.sales_count_hash
      sales_hash = {}
      all.each do |vendor|
        sales_hash[vendor] ||= vendor.sales.count
      end
      sales_hash
    end

    def self.most_revenue(n)
      all.sort_by(&:revenue).reverse[0..n-1]
    end

    def self.by_market(market_id)
      all.find_all { |vendor| vendor.market_id == market_id }
    end

    def self.revenue(date=nil)
      sum = 0
      all.each do |vendor|
        sum += vendor.revenue(date)
      end
      sum
    end
  end
end
