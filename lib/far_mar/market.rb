module FarMar
  class Market
    attr_accessor :id, :name, :address, :city, :county, :state, :zip, :markets

    def initialize
      @markets = CSV.read("support/markets.csv")
    end

    def self.all
      @markets
    end

    def self.find(id)

    end
  end
end

#To use anything we've defined in this class, use this:
#FarMar::Market
#FarMar::Sale
