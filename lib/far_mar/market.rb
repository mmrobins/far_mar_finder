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

    def vendors
      FarMar::Vendor.all
    end

    def products
      v = vendors.select { |vendor| vendor.market_id = @id }
      p = v.collect { |v| v.products }
    end

  end
end

#To use anything we've defined in this class, use this:
#FarMar::Market
#FarMar::Sale
