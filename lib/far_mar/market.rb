module FarMar
  class Market
    # @@markets = CSV.read("support/markets.csv").map do |m|
    #   Market.new(m)
    # end

    attr_accessor :id, :name, :address, :city, :county, :state, :zip

    def initialize(m_array)
       @id = m_array[0].to_i
       @name = m_array[1]
       @address = m_array[2]
       @city = m_array[3]
       @county = m_array[4]
       @state= m_array[5]
       @zip = m_array[6]
    end

    def self.all
      @markets ||= CSV.read("support/markets.csv").map do |m|
        Market.new(m)
      end
    end

    def self.find(id)
      all.find { |m| m.id == id }
    end

    def self.search(query)
      #markets_vendors = FarMar::Vendor.all + all
      s =[]
      FarMar::Vendor.all.select { |o| o.name.downcase.include? query.downcase }.each do |v|
        s << v.market
      end

      all.select { |o| o.name.downcase.include? query.downcase }.each do |m|
        s << m
      end

      return s
    end

    def vendors
      FarMar::Vendor.all.select { |vendor| vendor.market_id == @id }
    end

    def products
      vendors.collect { |v| v.products }.flatten
    end

    def prefered_vendor
      vendors.collect { |v| v.revenue }.max
    end

  end
end

#To use anything we've defined in this class, use this:
#FarMar::Market
#FarMar::Sale
