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
      @markets ||= CSV.read("support/markets.csv").map do |m|
        Market.new(m)
      end
    end

    def self.find(id)
      all.find { |m| m.id == id }
    end

    def self.search(query)
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
      max_rev = vendors.collect { |v| v.revenue }.max
      vendors.find { |v| v.revenue == max_rev}
    end

    def prefered_vendor_by_date(date)
      vendors.sort_by {|v| v.sales_for_day(date)}.last
    end


      # FarMar::Sale.all.purchase_time.date == date
      #
      # #vendors.select do {|v| v.sales}
      # FarMar::Sale.between(date, )
      #
      # sales_on_date = vendors.select do |v|
      #    v.sales.select {|s| s.purchase_time.day == date.day && s.purchase_time.mon == date.mon}
      #  end
      #sales_on_date.find { |v| v.revenue == max_rev}


    def worst_vendor
      min_rev = vendors.collect { |v| v.revenue }.min
      vendors.find { |v| v.revenue == min_rev}
    end

    def worst_vendor_by_date(date)
      vendors.sort_by {|v| v.sales_for_day(date)}.first
    end

  end
end
