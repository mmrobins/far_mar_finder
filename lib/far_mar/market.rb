module FarMar
  class Market
    attr_reader :id, :name, :address, :city, :county, :state, :zip

    def initialize(market_array)
      @id = market_array[0].to_i
      @name = market_array[1]
      @address = market_array[2]
      @city = market_array[3]
      @county = market_array[4]
      @state = market_array[5]
      @zip = market_array[6]
    end

    @@markets = nil
    def self.all(file_path="./support/markets.csv")
      if @@markets==nil
        file_contents = CSV.read(file_path)
        @@markets ||= file_contents.collect { |market| Market.new(market) }
      end
      @@markets
    end

    def vendors
      Vendor.all # next step: not loading this a million times
      Vendor.by_market(@id)
    end

    def self.find(id)
      all.find { |market| market.id == id }
    end

    def self.search(search_term)
      search_term.downcase!
      all.find_all do |market|
        (market.name.downcase.include? search_term) || (market.vendor_names.include? search_term)
      end
    end

    def prefered_vendor(date = nil)
      highest_revenue = 0
      best_vendor = nil
      vendors.each do |vendor|
        if vendor.revenue(date) > highest_revenue
          highest_revenue = vendor.revenue(date)
          best_vendor = vendor
        end
      end
      best_vendor
    end

    def worst_vendor(date = nil)
      sale_sums = {}
      vendors.each do |vendor|
        sale_sums[vendor] = vendor.revenue(date)
      end
      sale_sums.delete_if { |k, v| v == 0 }
      lowest_revenue = sale_sums.values.min
      sale_sums.key(lowest_revenue)
    end

    def vendor_names
      vendors.collect { |vendor| vendor.name.downcase }.join(" ")
    end

    def products
      vendors.collect { |vendor| vendor.products }
    end
  end
end
