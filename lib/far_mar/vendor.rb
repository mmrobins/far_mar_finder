module FarMar
  class Vendor
    attr_reader :id, :name, :no_of_employees, :market_id

    def initialize(vendor_array)
      @id = vendor_array[0].to_i
      @name = vendor_array[1]
      @no_of_employees = vendor_array[2].to_i
      @market_id = vendor_array[3].to_i
    end

    @@vendors = nil
    def self.all(file_path="./support/vendors.csv")
      if @@vendors == nil
        file_contents = CSV.read(file_path)
        @@vendors ||= file_contents.collect { |vendor| Vendor.new(vendor)}
      end
      @@vendors
    end

    def market
      Market.find(@market_id)
    end

    def products
      Product.all
      Product.by_vendor(@id)
    end

    def revenue(date = nil)
      sum = 0
      sales(date).each { |sale| sum += sale.amount }
      sum
    end

    def sales(date = nil) #date is a date object (not a date time obj)
      Sale.all
      sales = Sale.by_vendor(@id)
      if date != nil
        sales = sales.find_all { |sale| sale.purchase_time === date }
      end
      sales
    end

  #Maybe all self methods should run on .all???
    def self.most_revenue(n)
      rev_hash = revenue_hash
      revenue_array = rev_hash.values.sort.reverse
      revenue_array = revenue_array.slice(0...n)
      revenue_array.collect do |rev_amount|
        rev_hash.key(rev_amount)
      end
    end

    def self.revenue_hash
      rev_hash = {}
      all.each do |vendor|
        rev_hash[vendor] ||= vendor.revenue
      end
      rev_hash
    end

    def self.by_market(market_id)
      all.find_all { |vendor| vendor.market_id == market_id }
    end

    def self.find(id)
      all.find { |vendor| vendor.id == id }
    end

    def self.revenue(date=nil)
      sum = 0
      all.each do |vendor|
        sum += vendor.revenue(date)
      end
      puts sum
      sum
    end
  end
end
