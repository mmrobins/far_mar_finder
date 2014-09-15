module FarMar
  class Market
    attr_reader :id, :name, :address, :city, :county, :state, :zip, :vendors

    def initialize(market_array)
      @id = market_array[0].to_i
      @name = market_array[1]
      @address = market_array[2]
      @city = market_array[3]
      @county = market_array[4]
      @state = market_array[5]
      @zip = market_array[6].to_i

      @vendors = []
    end

    def self.all(file_path="./support/markets.csv")
      file_contents = CSV.read(file_path)
      @@markets = file_contents.collect { |market| Market.new(market) }
    end

    def self.find(id)
      @@markets.find { |market| market.id == id }
    end

  end
end
