module FarMar
  class Sale

    attr_accessor :id, :amount, :purchase_time, :vendor_id, :product_id

    def initialize(s_array)
      @id = s_array[0].to_i
      @amount = s_array[1].to_i
      @purchase_time = Time.parse(s_array[2])
      @vendor_id = s_array[3].to_i
      @product_id = s_array[4].to_i
    end

    def self.all_by_product
      @all_by_product ||= all.group_by(&:product_id)
    end

    def self.all_by_vendor
      @all_by_vendor ||= all.group_by(&:vendor_id)
    end

    def self.all
      @sales ||= CSV.read("support/sales.csv").map do |s|
        Sale.new(s)
      end
    end

    def self.find(id)
      all.find { |s| s.id == id }
    end

    def vendor
      FarMar::Vendor.all.find { |v| v.id == @vendor_id }
    end

    def product
      FarMar::Product.all.find { |p| p.vendor_id = @vendor_id }
    end

    def self.between(beginning_time, end_time)
      b = Time.parse(beginning_time)
      e = Time.parse(end_time)
      self.all.select { |s| s.purchase_time >= b && s.purchase_time <= e }.count
    end

  end

end
