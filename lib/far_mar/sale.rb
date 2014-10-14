module FarMar
  class Sale < Aspect
    set_path "./support/sales.csv"
    attr_reader :id, :amount, :purchase_time, :vendor_id, :product_id

    def initialize(sale_array)
      @id = sale_array[0].to_i
      @amount = sale_array[1].to_i
      @purchase_time = convert_time(sale_array[2])
      @vendor_id = sale_array[3].to_i
      @product_id = sale_array[4].to_i
    end

    def self.grouped_by_product
      @grouped_by_product ||= all.group_by {|s| s.product_id}
    end

    def self.grouped_by_vendor
      @grouped_by_vendor ||= all.group_by {|s| s.vendor_id}
    end

    def self.by_product(product_id)
      grouped_by_product[product_id] || []
    end

    def self.by_vendor(vendor_id)
      grouped_by_vendor[vendor_id] || []
    end

    def self.between(beginning_time, end_time)
      time_range = (beginning_time..end_time)
      result = all.find_all { |sale| time_range.cover? sale.purchase_time }
    end

    def convert_time(string)
      DateTime.parse(string)
    end

    def self.find_by_amount(search_amount)
      all.find { |object| object.amount == search_amount }
    end

    def self.find_all_by_date(search_date) #must be date object
      all.find_all { |object| object.purchase_time === search_date }
    end

    def vendor
      Vendor.all
      Vendor.find(@vendor_id)
    end

    def product
      Product.all
      Product.find(@product_id)
    end
  end
end
