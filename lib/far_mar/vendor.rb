module FarMar
  class Vendor
    attr_reader :id, :name, :no_of_employees, :market_id

    def initialize(vendor_array)
      @id = vendor_array[0].to_i
      @name = vendor_array[1]
      @no_of_employees = vendor_array[2].to_i
      @market_id = vendor_array[3].to_i
    end

    def self.all(file_path="./support/vendors.csv")
      file_contents = CSV.read(file_path)
      @@vendors ||= file_contents.collect { |vendor| Vendor.new(vendor)}
    end

    def market
      Market.find(@market_id)
    end

    def revenue(date=nil)
      sum = 0
      sales(date).each { |sale| sum += sale.amount }
      sum
    end

    # def time_to_day(time)
    #   Date.new(time.year, time.month, time.day)
    # end

    def products
      Product.all
      Product.by_vendor(@id)
    end

    def sales(date = nil) #date is a date object (not a date time obj)
      Sale.all
      sales = Sale.by_vendor(@id)
      if date != nil
        sales = sales.collect { |sale| sale.purchase_time == date }
      end
      sales
    end

    def self.by_market(market_id)
      @@vendors.find_all { |vendor| vendor.market_id == market_id }
    end

    def self.find(id)
      @@vendors.find { |vendor| vendor.id == id }
    end
  end
end
