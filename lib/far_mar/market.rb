module FarMar
  # This creates a market class
  class Market
    attr_accessor :id, :name, :address, :city, :county, :state, :zip

    def initialize(m_array)
      @id = m_array[0].to_i
      @name = m_array[1] || ''
      @address = m_array[2] || ''
      @city = m_array[3] || ''
      @county = m_array[4] || ''
      @state = m_array[5] || ''
      @zip = m_array[6] || ''
    end

    def self.all
      @markets ||= CSV.read("support/markets.csv").map do |m|
        Market.new(m)
      end
    end

    def self.find(id)
      all.find { |m| m.id == id }
    end

    def self.find_by_name(name)
      all.find { |m| m.name.downcase == name.downcase }
    end

    def self.find_by_city(city)
      all.find { |m| m.city.downcase == city.downcase }
    end

    def self.find_by_state(state)
      all.find { |m| m.state.downcase == state.downcase }
    end

    def self.find_by_zip(zip)
      all.find { |m| m.zip == zip }
    end

    def self.find_all_by_name(name)
      all.select { |m| m.name.downcase.include? name.downcase }
    end

    def self.find_all_by_city(city)
      all.select { |m| m.city.downcase.include? city.downcase }
    end

    def self.find_all_by_state(state)
      all.select { |m| m.state.downcase.include? state.downcase }
    end

    def self.find_all_by_zip(zip)
      all.select { |m| m.zip[0..1].include? zip[0..1] }
    end

    def self.search(query)
      s = []
      FarMar::Vendor.all.select { |o| o.name.downcase.include? query.downcase }.each do |v|
        s << v.market
      end

      all.select { |o| o.name.downcase.include? query.downcase }.each do |m|
        s << m
      end
    end

    def vendors
      FarMar::Vendor.all.select { |vendor| vendor.market_id == @id }
    end

    def products
      vendors.collect { |v| v.products }.flatten
    end

    def prefered_vendor
      max_rev = vendors.collect { |v| v.revenue }.max
      vendors.find { |v| v.revenue == max_rev }
    end

    def prefered_vendor_by_date(date)
      vendors.sort_by { |v| v.revenue_by_date(date) }.last
    end

    def worst_vendor
      min_rev = vendors.collect { |v| v.revenue }.min
      vendors.find { |v| v.revenue == min_rev }
    end

    def worst_vendor_by_date(date)
      vendors.sort_by { |v| v.revenue_by_date(date) }.first
    end

  end
end
