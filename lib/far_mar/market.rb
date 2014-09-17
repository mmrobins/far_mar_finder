require "./lib/far_mar/aspect.rb"

module FarMar
  class Market < FarMar::Aspect
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

    def vendors
      Vendor.all
      Vendor.by_market(@id)
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

    def self.find_by_address(search_term)
      search_term.downcase!
      all.find do |object|
        unless object.address == nil
          object.address.downcase == search_term
        end
      end
    end

    def self.find_by_city(search_term)
      search_term.downcase!
      all.find do |object|
        unless object.city == nil
          object.city.downcase == search_term
        end
      end
    end

    def self.find_by_county(search_term)
      search_term.downcase!
      all.find do |object|
        unless object.county == nil
          object.county.downcase == search_term
        end
      end
    end

    def self.find_by_state(search_term)
      search_term.downcase!
      all.find do |object|
        unless object.state == nil
          object.state.downcase == search_term
        end
      end
    end

    def self.find_by_zip(search_term)
      all.find { |object| object.zip == search_term }
    end
  end
end
