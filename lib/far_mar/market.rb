module FarMar
  class Market
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
      @markets = CSV.read("support/markets.csv").map do |m|
        Market.new(m)
      end
    end

    def self.find(id)
      @markets.find { |m| m.id == id }
    end

    def vendors
      FarMar::Vendor.all
    end

  end
end

#To use anything we've defined in this class, use this:
#FarMar::Market
#FarMar::Sale
